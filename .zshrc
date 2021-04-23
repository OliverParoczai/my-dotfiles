#.zshrc
source ~/Scripts/zsh-git-prompt/zshrc.sh
source ~/Scripts/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz promptinit
promptinit
setopt prompt_subst
#PROMPT="%F{green}%n%f@%m %F{green}%~%f $(git_super_status)> "
PROMPT='%F{green}%n%f@%m %F{green}%~%f $(git_super_status)%\> '

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#For auto correction
#setopt correct
if [ -f ~/Scripts/Neofetch/neofetch ]; then
    ~/Scripts/Neofetch/neofetch --config ~/Scripts/Neofetch/neofetch.conf
else
    neofetch --config ~/Scripts/Neofetch/neofetch.conf
fi
