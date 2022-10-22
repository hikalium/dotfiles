source ~/.bashrc

# opam configuration
test -r /Users/hikalium/.opam/opam-init/init.sh && . /Users/hikalium/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
source "$HOME/.cargo/env"
