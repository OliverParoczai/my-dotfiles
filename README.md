# my-dotfiles

This repository contains the dotfiles I use for my Linux installs.

It consists of a modified *zsh* config (autocompletion, custom history and prompt, a few added functions that can be toggled in .zshrc, and a customized Neofetch instance)

I mainly use this repository for quickly setting up my devices, but feel free to use and/or contribute to it if you'd like. :)

### How to download and install

```
git clone https://github.com/OliverParoczai/my-dotfiles
git submodule init
cd my-dotfiles
./INSTALL.sh
```

The included 'INSTALL.sh' script will install the required packages and folders at the correct locations. I recommend manually checking the script before running it for security reasons.

### How it works

The included .zshrc has a few bonus functions included for special use-cases:

- Overwrite: You can override an existing command or even add a new command by placing a binary file or script into the ~/Scripts/Overwrite folder and changing `OVERWRITE=false` to `true` in `~/.zshrc`. It works by adding this folder to the front of the PATH variable, thus running all programs from this folder that can be found in it, even if they exist somewhere else. I mainly use it for wrapping commands in specific scripts (like pushing a notification when program completes, etc.), and for adding new commands in a portable way.
- RunAfter: If it gets enabled, the ~/Scripts/RunAfter.sh script will run after the shell is initalized. Good for setting up quick command aliases or adding specific folders to PATH in a non-permanent way. You can enable it by changing `RUNAFTER=false` to `true` in `~/.zshrc`.
