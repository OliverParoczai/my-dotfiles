#!/bin/bash

includedFiles=(.zshrc Scripts)

checkForPackages() {
  pkg=$1
  if ! command -v $pkg &> /dev/null; then
    echo " not installed"
    echo "i> Trying to install $pkg.."
    if command -v apt-get &> /dev/null; then
      su -c "apt-get install $pkg"
    elif command -v pacman &> /dev/null; then
      su -c "pacman -S $pkg"
    else
      echo "!> Unknown package manager. Please install $pkg manually"
    fi
  else
    echo " installed"
  fi
}

copyFilesToHome() {
  if ! command -v git &> /dev/null; then
    echo "git not installed, please check submodules manually"
  else
    IFS=$'\n'
    serror=0
    sstatus=($(git submodule status | cut -c1-1))
    for s in $sstatus; do
      if [ "$s" == "-" ]; then
        serror=1
      fi
    done
    if [ $serror == 1 ]; then
      echo "!> git submodules not installed correctly."
      read -p "?> Proceed (y/N)? " choice
      case "$choice" in
        y|Y ) echo "!> There may be errors with the installation";;
        * ) echo "!> Exiting without running."; exit 0;;
      esac
    else
      echo "i> No git errors found"
    fi
  fi
  for f in "${includedFiles[@]}"; do
    echo "i> Copying ./$f to ~/$f..."
    \cp -r ./$f ~
    chmod -R +x ~/$f
  done
}

echo -n "i> Checking for zsh..."
checkForPackages zsh
echo -n "i> Checking for neofetch..."
checkForPackages neofetch
echo "!> This command will overwrite your ~/Scripts folder and ~/.zshrc file."
read -p "?> Proceed (y/N)? " choice
case "$choice" in
  y|Y ) copyFilesToHome;;
  * ) echo "!> Exiting without running.";;
esac
