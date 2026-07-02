#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "======================================"
echo "   Nerfe Termux Environment Installer"
echo "======================================"
echo

echo "[1/8] Updating packages..."
pkg update -y
pkg upgrade -y

echo
echo "[2/8] Installing packages..."
pkg install -y \
    zsh \
    git \
    fastfetch \
    python \
    nodejs \
    openssh \
    curl \
    wget \
    nano \
    vim \
    clang \
    make \
    cmake \
    zip \
    unzip

echo
echo "[3/8] Requesting storage permission..."
termux-setup-storage

echo
echo "[4/8] Creating Workplace folder..."
mkdir -p ~/storage/shared/Workplace
ln -sf ~/storage/shared/Workplace ~/Workplace

echo
echo "[5/8] Installing Zsh plugins..."
mkdir -p ~/.zsh/plugins

if [ ! -d ~/.zsh/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ~/.zsh/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        ~/.zsh/plugins/zsh-syntax-highlighting
fi

echo
echo "[6/8] Installing configuration..."

cp configs/zshrc ~/.zshrc

mkdir -p ~/.termux
cp configs/termux.properties ~/.termux/termux.properties

echo
echo "[7/8] Reloading Termux settings..."
termux-reload-settings

echo
echo "[8/8] Setting Zsh as the default shell..."
chsh -s zsh

echo
echo "======================================"
echo " Installation Complete!"
echo "======================================"
echo
echo "Please restart Termux."