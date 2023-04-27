# dotfiles
dotfiles for hikalium

```
./link.sh
```

## macOS
```
mkdir -p ~/Desktop/SS && defaults write com.apple.screencapture location ~/Desktop/SS

HOST=t05.z01.hikalium.com
echo ${HOST}
sudo scutil --set ComputerName ${HOST}
sudo scutil --set HostName ${HOST}
sudo scutil --set LocalHostName `echo $HOST | sed -E 's/\..*$//'`
```

## fonts
- https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it
  - Install OTF fonts
