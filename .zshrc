#--ZSHRC--#
#MADE BY OLIVER PAROCZAI#
#--OLIVERPAROCZAI.DEV--#
source ~/Scripts/zsh-git-prompt/zshrc.sh
source ~/Scripts/zsh-autosuggestions/zsh-autosuggestions.zsh

#--SETTINGS--#
RUNAFTER=false   #enables running the Scripts/RunAfter.sh script after shell starts
OVERWRITE=false  #enables the ~/Scripts/Overwrite folder for commands that should be added to the path and/or overwritten

#--PROMPT--#
autoload -Uz promptinit
promptinit
setopt prompt_subst
#PROMPT="%F{green}%n%f@%m %F{green}%~%f $(git_super_status)> "
PROMPT='%F{green}%n%f@%m %F{green}%~%f $(git_super_status)%\> '

#--HISTORY--#
setopt histignorealldups sharehistory
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#--COMPLETION--#
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

#--SEARCH--#
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#--KEYBINDS--#
bindkey -e
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#--NEOFETCH--#
if [ -f ~/Scripts/Neofetch/neofetch ]; then
    ~/Scripts/Neofetch/neofetch --config ~/Scripts/Neofetch/neofetch.conf
else
    neofetch --config ~/Scripts/Neofetch/neofetch.conf
fi

#--OVERWRITE--#
if [ -d ~/Scripts/Overwrite ] && [ $OVERWRITE = true ]; then
    export PATH=~/Scripts/Overwrite:$PATH
    echo "---------------------------------------------------"
    echo "This unit houses the following custom commands:"
    echo $(ls ~/Scripts/Overwrite)
    echo ""
fi

#--RUNAFTER--#
if [ -f ~/Scripts/RunAfter.sh ] && [ $RUNAFTER = true ]; then
    . ~/Scripts/RunAfter.sh
fi
