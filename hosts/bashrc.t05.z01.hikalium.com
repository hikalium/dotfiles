source ~/.bashrc.common
export BASH_SILENCE_DEPRECATION_WARNING=1

export RISCV_OPENOCD_PATH=/Users/hikalium/package/riscv-openocd-0.10.0-2019.08.2-x86_64-apple-darwin
export RISCV_PATH=/Users/hikalium/package/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-apple-darwin

export PATH="$PATH":'/Users/hikalium/package/zen-macos-x86_64-0.8.20191124+552247019/'
