#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "======================================"
echo "  Nerfe Termux Environment Installer"
echo "======================================"
echo

echo "[1/7] Updating packages..."
pkg update -y
pkg upgrade -y

echo
echo "[2/7] Installing packages..."
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
echo "[3/7] Requesting storage permission..."
termux-setup-storage


sleep 3

echo
echo "[4/7] Creating Workplace shortcut..."
if [ -d "$HOME/storage/shared" ]; then
    mkdir -p "$HOME/storage/shared/Workplace"
    ln -sfn "$HOME/storage/shared/Workplace" "$HOME/Workplace"
    echo "✓ Workplace linked."
else
    echo "⚠ Storage permission not granted."
    echo "Grant permission and rerun the script if you want the Workplace link."
fi

echo
echo "[5/7] Installing Zsh plugins..."

mkdir -p ~/.zsh/plugins

[ -d ~/.zsh/plugins/zsh-autosuggestions ] || \
git clone https://github.com/zsh-users/zsh-autosuggestions \
~/.zsh/plugins/zsh-autosuggestions

[ -d ~/.zsh/plugins/zsh-syntax-highlighting ] || \
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
~/.zsh/plugins/zsh-syntax-highlighting

echo
echo "[6/7] Creating .zshrc..."

cat > ~/.zshrc <<'EOF'
clear

# Banner
echo -e "\e[36m"
echo "███╗   ██╗███████╗██████╗ ███████╗███████╗"
echo "████╗  ██║██╔════╝██╔══██╗██╔════╝██╔════╝"
echo "██╔██╗ ██║█████╗  ██████╔╝█████╗  █████╗  "
echo "██║╚██╗██║██╔══╝  ██╔══██╗██╔══╝  ██╔══╝  "
echo "██║ ╚████║███████╗██║  ██║██║     ███████╗"
echo "╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝"
echo -e "\e[0m"

fastfetch --logo arch

PROMPT='%F{cyan}┌──(termux㉿Nerfe)-[%~]
└─$ %f'

alias cls='clear'
alias py='python'
alias update='pkg update && pkg upgrade -y'
alias copy='termux-clipboard-set'
alias paste='termux-clipboard-get'

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF

echo
echo "[7/7] Switching to Zsh..."

chsh -s zsh || true

echo
echo "======================================"
echo " Installation Complete!"
echo "======================================"
echo
echo "Restart Termux to apply all changes."