#!/data/data/com.termux/files/usr/bin/bash
echo "Prompt username:"
read USERNAME
echo "Banner name:"
read BANNER

pkg update -y && pkg upgrade -y
pkg install -y zsh git fastfetch python nodejs openssh curl wget nano vim clang make cmake zip unzip toilet

termux-setup-storage

mkdir -p ~/storage/shared/Workplace
ln -sf ~/storage/shared/Workplace ~/Workplace

mkdir -p ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting

mkdir -p ~/.config/termux
toilet -f future "$BANNER" > ~/.config/termux/banner.txt

sed "s/__USERNAME__/$USERNAME/g" configs/zshrc.template > ~/.zshrc

mkdir -p ~/.termux
cp configs/termux.properties ~/.termux/termux.properties
termux-reload-settings
chsh -s zsh

echo "Done! Restart Termux."
