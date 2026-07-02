#!/data/data/com.termux/files/usr/bin/bash

set -e

clear

echo "========================================"
echo "   Nerfe Termux Setup Installer"
echo "========================================"
echo

if [ -z "$PREFIX" ]; then
    echo "Error: This installer must be run inside Termux."
    exit 1
fi

echo "[1/8] Updating packages..."
pkg update -y
pkg upgrade -y

echo
echo "[2/8] Installing required packages..."
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

echo "Waiting for Android to finish..."
sleep 5

echo
echo "[4/8] Creating Workplace folder..."

if [ -d "$HOME/storage/shared" ]; then
    mkdir -p "$HOME/storage/shared/Workplace"
    ln -sfn "$HOME/storage/shared/Workplace" "$HOME/Workplace"
    echo "✓ Workplace linked."
else
    echo "⚠ Storage permission not granted."
    echo "Skipping Workplace symlink."
fi

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
echo "[6/8] Installing .zshrc..."

if [ -f configs/zshrc.template ]; then
    cp configs/zshrc.template ~/.zshrc
    echo "✓ Installed .zshrc"
else
    echo "✗ configs/zshrc.template not found."
    exit 1
fi

echo
echo "[7/8] Installing Termux configuration..."

mkdir -p ~/.termux

if [ -f configs/termux.properties ]; then
    cp configs/termux.properties ~/.termux/termux.properties
    termux-reload-settings
    echo "✓ Installed termux.properties"
else
    echo "⚠ configs/termux.properties not found."
fi

echo
echo "[8/8] Changing default shell..."

chsh -s zsh || true

echo
echo "========================================"
echo " Installation Complete!"
echo "========================================"
echo
echo "Please restart Termux."
echo
echo "Installed:"
echo "  ✓ Zsh"
echo "  ✓ Fastfetch"
echo "  ✓ Git"
echo "  ✓ Python"
echo "  ✓ Node.js"
echo "  ✓ Developer tools"
echo "  ✓ Zsh plugins"
echo "  ✓ Nerfe configuration"
echo
echo "Enjoy!"