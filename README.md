# Termux Nerfe Setup

Run:

```bash
pkg update && pkg upgrade -y
pkg install git
git clone https://github.com/Humble2021/termux-nerfe-setup.git
cd termux-nerfe-setup
bash install.sh
```

The installer will:
- Install packages
- Setup storage
- Create Workplace on shared storage
- Create symlinks
- Install Zsh plugins
- Configure Fastfetch, Zsh, Git and extra keys
