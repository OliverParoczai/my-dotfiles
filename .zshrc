#--ZSHRC--#
#MADE BY OLIVER PAROCZAI#
#--OLIVERPAROCZAI.DEV--#
source ~/Scripts/zsh-git-prompt/zshrc.sh
source ~/Scripts/zsh-autosuggestions/zsh-autosuggestions.zsh

#--SETTINGS--#
RUNAFTER=true   #enables running the ~/Scripts/RunAfter.sh script after shell starts
OVERWRITE=true  #enables the ~/Scripts/Overwrite folder for commands that should be added to the path and/or overwritten
FETCH="neofetch" #possible values: fastfetch, neofetch, none
FETCH_USE_CUSTOM_LOGO=false #possible values: true: uses custom logo specified below (in run_fetch function) for fetch, false: uses standard distro logos for fetch

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

#--FETCH--#
function run_fetch() {
    if [ $FETCH_USE_CUSTOM_LOGO = true ]; then #if using thinkpad logo is enabled
        if [ -z $(echo "$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$))" | grep "konsole") ]; then
            TP_LOGO_HIGHRES=false #Not running from supported terminal emulator, use low-res logo
        else
            TP_LOGO_HIGHRES=true #Running from supported terminal emulator, use high-res logo
        fi
    fi
    case "$FETCH" in
        "neofetch")
        #default option - Neofetch
            CUST_RES_LOGO_VAR=""
            if [ $FETCH_USE_CUSTOM_LOGO = true ]; then
                if [ -z $(echo "$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$))" | grep "konsole") ]; then # if not running from supported terminal emulator (currently tested with KDE Konsole only)
                    CUST_RES_LOGO_VAR="--ascii ~/Scripts/Neofetch/ascii/thinkpad-v-lowres.txt --ascii_colors 15 1" # replace the high res logo with a lower res one
                else
                    CUST_RES_LOGO_VAR="--ascii ~/Scripts/Neofetch/ascii/thinkpad-v.txt --ascii_colors 15 1" # high res default logo
                fi
            fi

            if [ -f ~/Scripts/Neofetch/neofetch ]; then
                eval ~/Scripts/Neofetch/neofetch --config ~/Scripts/Neofetch/neofetch.conf $CUST_RES_LOGO_VAR
            else
                eval neofetch --config ~/Scripts/Neofetch/neofetch.conf $CUST_RES_LOGO_VAR
            fi
            ;;
        "fastfetch")
        #secondary option - Fastfetch (better, but not setting as default since it's not yet available from most distro repositories)
            CUST_RES_LOGO_VAR=""
            if [ $FETCH_USE_CUSTOM_LOGO = true ]; then
                if [ -z $(echo "$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$))" | grep "konsole") ]; then # if not running from supported terminal emulator (currently tested with KDE Konsole only)
                    CUST_RES_LOGO_VAR="-l ~/Scripts/fastfetch/ascii/thinkpad-v-lowres.txt --logo-color-1 white --logo-color-2 red" # replace the high res logo with a lower res one
                else
                    CUST_RES_LOGO_VAR="-l ~/Scripts/fastfetch/ascii/thinkpad-v.txt --logo-color-1 white --logo-color-2 red" # high res default logo
                fi
            fi
            eval fastfetch --config ~/Scripts/fastfetch/config.jsonc $CUST_RES_LOGO_VAR
            ;;
        *)
            echo "An incorrect option for FETCH is set in ~/.zshrc:10"
    esac
}

if [ "$FETCH" != "none" ]; then # Run the fetch program if it is enabled
    run_fetch
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
