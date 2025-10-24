# my-dotfiles

This repository contains the main dotfiles I use for my Linux installations.

It includes a modified *zsh* config (auto-completion, customized history and prompt, several additional functions that can be toggled in .zshrc, and a customized Neofetch and Fastfetch instance)

There are custom fetch logos included for ThinkPad laptops, sourced from [roadkell's ascii-logos](https://github.com/roadkell/ascii-logos) repository. These are not used by default, but can be enabled in the config files.

I mainly use this repository for quickly setting up my workstations but feel free to use and contribute if you're interested in the project. :)

### How to download and install

```
git clone --recurse-submodules https://github.com/OliverParoczai/my-dotfiles
cd my-dotfiles
./INSTALL.sh
chsh -s $(which zsh)
```

The included 'INSTALL.sh' script will install the required packages and folders at the correct locations. The shell needs to be manually set. For security purposes, I recommend reviewing the script manually before executing it.

### How it works

The included .zshrc has a few optional functions for special use cases:

- Overwrite: You can replace an existing command or add a new command by placing a binary file or script into the ~/Scripts/Overwrite folder and changing `OVERWRITE=false` to `true` in `~/.zshrc`. It works by adding this folder to the front of the PATH variable, thus running all programs from this folder that can be found in it, even if they exist somewhere else. I mainly use it for wrapping commands in specific scripts (like pushing a notification when a program completes, etc.), and for adding new commands in a portable way.
- RunAfter: If enabled, the ~/Scripts/RunAfter.sh script will run after the shell is initialized. Good for setting up quick command aliases or adding specific folders to PATH in a non-permanent way. You can enable it by changing `RUNAFTER=false` to `true` in `~/.zshrc`.
- Fetch: It is possible to choose from two fetch programs at the moment:
    - Neofetch: the current default, a good and fully customizable all-rounder option
    - Fastfetch: Faster and more reliable than Neofetch, but still not available from all distro repositories
