# dotfiles
dotfiles for hikalium

## macOS
```
mkdir -p ~/Desktop/SS && defaults write com.apple.screencapture location ~/Desktop/SS

HOST=t05.z01.hikalium.com
echo ${HOST}
sudo scutil --set ComputerName ${HOST}
sudo scutil --set HostName ${HOST}
sudo scutil --set LocalHostName `echo $HOST | sed -E 's/\..*$//'`
```
