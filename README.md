# Neovim Setup Guide (with Plugins)

A simple and effective way to set up Neovim as a powerful code editor with useful plugins and sane defaults.

## Requirements

. Termux or any Linux-based environment

. Git installed

. Neovim 0.9+


## Installation Steps

Open your terminal and run the following commands:

```bash
pkg update && pkg upgrade
pkg install neovim git
git clone https://github.com/Rovikin/Neovim-Config.git
```

If the ~/.config directory does not exist yet, create it manually:

```bash
mkdir -p ~/.config
```

Then copy the Neovim configuration:

```bash
cp -rf ~/Neovim-Config/nvim ~/.config/
```

Once done, launch Neovim:

```bash
nvim
```

Neovim will automatically install all required plugins.
If it doesn't, or if you want to manually trigger plugin installation, type this inside Neovim:

```
:Lazy sync
```

Wait until the installation process completes.


---

## Features

. Plugin manager with lazy.nvim

. Preconfigured for productivity (LSP, syntax highlighting, file explorer, etc.)

. Ready for development in multiple languages

. Lightweight and optimized for Termux



---
