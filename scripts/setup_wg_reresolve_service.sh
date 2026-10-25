#!/bin/bash
# Install: sudo bash setup_wg_reresolve_service.sh
# Validate without installing: bash setup_wg_reresolve_service.sh --check
# Every 30s, check active wg-quick@ units; re-resolve peers with handshakes >135s old.
# Direct wg-quick invocations and NetworkManager connections are excluded.
# Logs: sudo journalctl -u wg-reresolve-dns.service
# Disable: sudo systemctl disable --now wg-reresolve-dns.timer
# Stop a running refresh: sudo systemctl stop wg-reresolve-dns.service
set -euo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin

if (( $# > 1 )) || [[ ${1:-} != '' && ${1:-} != --check ]]; then
    printf 'Usage: sudo bash setup_wg_reresolve_service.sh | bash setup_wg_reresolve_service.sh --check\n' >&2
    exit 2
fi
if [[ ${1:-} != --check ]] && (( EUID != 0 )); then
    printf 'Run with sudo bash, or use --check to validate without installing.\n' >&2
    exit 1
fi
for tool in wg systemctl systemd-analyze timeout install mktemp; do
    command -v "$tool" >/dev/null
done
stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT

# Unmodified upstream: https://git.zx2c4.com/wireguard-tools/tree/contrib/reresolve-dns/reresolve-dns.sh
# Git blob: c26c5b47199e86545952e8877cb2be410c43fcc4
cat > "$stage/reresolve-dns.sh" <<'WIREGUARD_EMBEDDED_0'
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (C) 2015-2026 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.

set -e
shopt -s nocasematch
shopt -s extglob
export LC_ALL=C

CONFIG_FILE="$1"
[[ $CONFIG_FILE =~ ^[a-zA-Z0-9_=+.-]{1,15}$ ]] && CONFIG_FILE="/etc/wireguard/$CONFIG_FILE.conf"
[[ $CONFIG_FILE =~ /?([a-zA-Z0-9_=+.-]{1,15})\.conf$ ]]
INTERFACE="${BASH_REMATCH[1]}"

process_peer() {
	[[ $PEER_SECTION -ne 1 || -z $PUBLIC_KEY || -z $ENDPOINT ]] && return 0
	[[ $(wg show "$INTERFACE" latest-handshakes) =~ ${PUBLIC_KEY//+/\\+}\	([0-9]+) ]] || return 0
	(( ($EPOCHSECONDS - ${BASH_REMATCH[1]}) > 135 )) || return 0
	wg set "$INTERFACE" peer "$PUBLIC_KEY" endpoint "$ENDPOINT"
	reset_peer_section
}

reset_peer_section() {
	PEER_SECTION=0
	PUBLIC_KEY=""
	ENDPOINT=""
}

reset_peer_section
while read -r line || [[ -n $line ]]; do
	stripped="${line%%\#*}"
	key="${stripped%%=*}"; key="${key##*([[:space:]])}"; key="${key%%*([[:space:]])}"
	value="${stripped#*=}"; value="${value##*([[:space:]])}"; value="${value%%*([[:space:]])}"
	[[ $key == "["* ]] && { process_peer; reset_peer_section; }
	[[ $key == "[Peer]" ]] && PEER_SECTION=1
	if [[ $PEER_SECTION -eq 1 ]]; then
		case "$key" in
		PublicKey) PUBLIC_KEY="$value"; continue ;;
		Endpoint) ENDPOINT="$value"; continue ;;
		esac
	fi
done < "$CONFIG_FILE"
process_peer
WIREGUARD_EMBEDDED_0

cat > "$stage/reresolve-all.sh" <<'WIREGUARD_EMBEDDED_1'
#!/bin/bash
set -euo pipefail

# wg-quick@.service passes its literal instance (%i) to wg-quick.
script_dir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
units=$(systemctl list-units --type=service --state=active --no-legend --plain --no-pager 'wg-quick@*.service')
interfaces=$(wg show interfaces)
read -r -a live_interfaces <<< "$interfaces"

refresh_interface() {
    local unit=$1 iface=$2 rc
    # Recheck after enumeration to avoid touching an already stopped tunnel.
    systemctl --quiet is-active "$unit" || return 0
    if [[ ! -r /etc/wireguard/$iface.conf ]]; then
        printf '%s: configuration is missing or unreadable\n' "$iface" >&2
        return 1
    fi
    if timeout --kill-after=1s 25s /bin/bash "$script_dir/reresolve-dns.sh" "$iface"; then
        return 0
    else
        rc=$?
        printf '%s: endpoint refresh failed (exit %s)\n' "$iface" "$rc" >&2
        return 1
    fi
}

pids=()
while read -r unit rest; do
    [[ -n $unit ]] || continue
    [[ $unit == wg-quick@*.service ]] || continue
    iface=${unit#wg-quick@}
    iface=${iface%.service}
    if [[ ! $iface =~ ^[a-zA-Z0-9_=+.-]{1,15}$ ]]; then
        printf 'Skipping unsupported wg-quick instance: %s\n' "$unit" >&2
        continue
    fi
    # Only touch live WireGuard interfaces belonging to active wg-quick units.
    found=false
    for live in "${live_interfaces[@]}"; do
        if [[ $live == "$iface" ]]; then found=true; break; fi
    done
    "$found" || continue
    refresh_interface "$unit" "$iface" &
    pids+=("$!")
done <<< "$units"

result=0
for pid in "${pids[@]}"; do
    wait "$pid" || result=1
done
exit "$result"
WIREGUARD_EMBEDDED_1

cat > "$stage/wg-reresolve-dns.service" <<'WIREGUARD_EMBEDDED_2'
[Unit]
Description=Re-resolve endpoints of all active wg-quick interfaces
Documentation=https://git.zx2c4.com/wireguard-tools/tree/contrib/reresolve-dns/README
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash /usr/local/libexec/wireguard-reresolve/reresolve-all.sh
Environment=PATH=/usr/sbin:/usr/bin:/sbin:/bin
Environment=WG_ENDPOINT_RESOLUTION_RETRIES=2
TimeoutStartSec=29s
TimeoutStopSec=1s
KillMode=control-group
UMask=0077
NoNewPrivileges=yes
ProtectSystem=strict
ProtectHome=yes
PrivateTmp=yes
WIREGUARD_EMBEDDED_2

cat > "$stage/wg-reresolve-dns.timer" <<'WIREGUARD_EMBEDDED_3'
[Unit]
Description=Check all active wg-quick endpoints every 30 seconds

[Timer]
OnCalendar=*-*-* *:*:00,30
AccuracySec=1s
RandomizedDelaySec=0
WakeSystem=false
Unit=wg-reresolve-dns.service

[Install]
WantedBy=timers.target
WIREGUARD_EMBEDDED_3

/bin/bash -n "$stage/reresolve-dns.sh"
/bin/bash -n "$stage/reresolve-all.sh"
systemd-analyze verify "$stage/wg-reresolve-dns.service" "$stage/wg-reresolve-dns.timer"
if [[ ${1:-} == --check ]]; then
    printf 'Embedded scripts and systemd units validated; nothing installed.\n'
    exit 0
fi

# Stop previous helper versions before replacing them; leave VPNs running.
for unit in wg-reresolve-dns-wg13.timer wg-reresolve-dns-wg13.service wg-reresolve-dns.timer wg-reresolve-dns.service; do
    state=$(systemctl show --property=LoadState --value "$unit")
    if [[ $state != not-found ]]; then
        if [[ $unit == wg-reresolve-dns-wg13.timer ]]; then
            systemctl disable --now "$unit"
        else
            systemctl stop "$unit"
        fi
    fi
done

install -d -o root -g root -m 0755 /usr/local/libexec/wireguard-reresolve
install -o root -g root -m 0755 "$stage/"reresolve-{dns,all}.sh /usr/local/libexec/wireguard-reresolve/
install -o root -g root -m 0644 "$stage/"wg-reresolve-dns.{service,timer} /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now wg-reresolve-dns.timer
systemctl list-timers --all wg-reresolve-dns.timer --no-pager
