# Termux Nerfe Setup

Run:

```bash
pkg update && pkg upgrade -y
pkg install git
git clone <YOUR_REPO_URL>
cd termux-nerfe-setup
bash install.sh
```

The installer will:
- Ask for prompt username
- Ask for banner name
- Install packages
- Setup storage
- Create Workplace on shared storage
- Create symlinks
- Install Zsh plugins
- Configure Fastfetch, Zsh, Git and extra keys
