#!/data/data/com.termux/files/usr/bin/bash

set -e

clear

echo "========================================"
echo "      Nerfe Termux Setup Installer"
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

echo
echo "If Android shows a storage permission dialog,"
echo "tap 'Allow', then press ENTER to continue."
read

echo
echo "[4/8] Setting up Workplace..."

if [ -d "$HOME/storage/shared" ]; then

    mkdir -p "$HOME/storage/shared/Workplace"

    if [ -L "$HOME/Workplace" ]; then

        echo "✓ Workplace symlink already exists."

    elif [ -d "$HOME/Workplace" ]; then

        echo "✓ Existing ~/Workplace directory found."
        echo "Keeping the existing directory."

    elif [ -e "$HOME/Workplace" ]; then

        echo "⚠ ~/Workplace exists but is not a directory."
        echo "Skipping symbolic link creation."

    else

        ln -s "$HOME/storage/shared/Workplace" "$HOME/Workplace"

        echo "✓ Created symbolic link:"
        echo "  $HOME/Workplace -> $HOME/storage/shared/Workplace"

    fi

else

    echo "⚠ Storage permission not granted."
    echo "Skipping Workplace setup."

fi

echo
echo "[5/8] Installing Zsh plugins..."

mkdir -p "$HOME/.zsh/plugins"

if [ ! -d "$HOME/.zsh/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$HOME/.zsh/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.zsh/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$HOME/.zsh/plugins/zsh-syntax-highlighting"
fi

echo
echo "[6/8] Creating .zshrc..."

cat > "$HOME/.zshrc" <<'EOF'
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

# System Info
fastfetch --logo arch

# Prompt
PROMPT='%F{cyan}┌──(termux㉿Nerfe)-[%~]
└─$ %f'

# Aliases
alias cls='clear'
alias py='python'
alias update='pkg update && pkg upgrade -y'
alias copy='termux-clipboard-set'
alias paste='termux-clipboard-get'

# Plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF

echo "✓ Created ~/.zshrc"

echo
echo "[7/8] Installing Termux configuration..."

mkdir -p "$HOME/.termux"

if [ -f "configs/termux.properties" ]; then
    cp "configs/termux.properties" "$HOME/.termux/termux.properties"
    termux-reload-settings
    echo "✓ Installed termux.properties"
else
    echo "⚠ configs/termux.properties not found."
fi

echo
echo "[8/8] Setting Zsh as default shell..."

chsh -s zsh || true

echo
echo "========================================"
echo "      Installation Complete!"
echo "========================================"
echo
echo "Installed:"
echo "  ✓ Zsh"
echo "  ✓ Git"
echo "  ✓ Fastfetch"
echo "  ✓ Python"
echo "  ✓ Node.js"
echo "  ✓ OpenSSH"
echo "  ✓ curl"
echo "  ✓ wget"
echo "  ✓ nano"
echo "  ✓ vim"
echo "  ✓ clang"
echo "  ✓ make"
echo "  ✓ cmake"
echo "  ✓ zip"
echo "  ✓ unzip"
echo "  ✓ Zsh Autosuggestions"
echo "  ✓ Zsh Syntax Highlighting"
echo "  ✓ Nerfe Zsh Configuration"
echo "  ✓ Termux Configuration"
echo

if [ -L "$HOME/Workplace" ]; then
    echo "Workspace:"
    echo "  ~/Workplace -> ~/storage/shared/Workplace"
elif [ -d "$HOME/Workplace" ]; then
    echo "Workspace:"
    echo "  Using existing ~/Workplace directory."
else
    echo "Workspace:"
    echo "  ~/storage/shared/Workplace"
fi

echo
echo "Restart Termux to apply all changes."