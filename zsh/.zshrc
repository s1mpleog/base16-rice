# Uncomment for profiling only
# zmodload zsh/zprof

# History configuration (move to top - lightweight)
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Environment variables (set early)
export EDITOR='nvim'
export PATH=$PATH:"$HOME/.spicetify"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold (red)
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink (yellow)
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video (blue bg)
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline (white)
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1

ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

export TERM=xterm-256color

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

if [[ ! -f ${zsh_plugins}.zsh ]] || [[ ${zsh_plugins}.txt -nt ${zsh_plugins}.zsh ]]; then
    #source "${XDG_DATA_HOME:-$HOME/.local/share}/antidote/antidote.zsh"
    source "$HOME/.antidote/antidote.zsh"
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Just source the static bundle - no antidote runtime overhead
source ${zsh_plugins}.zsh

# Compile plugin file for faster loading
[[ ! -f ${zsh_plugins}.zsh.zwc ]] || \
   [[ ${zsh_plugins}.zsh -nt ${zsh_plugins}.zsh.zwc ]] && \
    zcompile ${zsh_plugins}.zsh

# Autosuggestions configuration (after plugin load)
# ZSH_AUTOSUGGEST_USE_ASYNC=1
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#ZSH_AUTOSUGGEST_MANUAL_REBIND=1

bindkey -e

# bindkey '^[OA' history-substring-search-up
# bindkey '^[OB' history-substring-search-down
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'

bindkey '^?' backward-delete-char  # Backspace
bindkey '^[[3~' delete-char        # Delete
bindkey '^[[H' beginning-of-line   # Home
bindkey '^[[F' end-of-line         # End
bindkey '^[[1;5C' forward-word     # Ctrl+Right
bindkey '^[[1;5D' backward-word    # Ctrl+Left

bindkey '^ ' autosuggest-accept  # Ctrl+Space accepts suggestion
bindkey '^f' autosuggest-accept  # or Ctrl+F

# Functions
function record() {
    local datetime=$(date +%Y-%m-%d_%H-%M-%S)
    gpu-screen-recorder -w portal -f 60 -k hevc -q 50000 -bm cbr \
        -a default_output \
        -o "$HOME/Videos/recording_${datetime}.mp4"
}

# Aliases
#alias cd='z'
alias ls='eza -a --icons --git --group-directories-first'
alias ll='eza -al --icons --git --header --group'
alias lt='eza -a --tree --level=2 --icons --git-ignore'
alias lt2='eza -a --tree --level=2 --icons'
alias lt3='eza -a --tree --level=3 --icons'
alias llt='eza -al --icons --git --sort=modified --reverse'
alias lls='eza -al --icons --git --sort=size --reverse'
alias lsd='eza -aD --icons'
alias lla='eza -al --icons --git --header --group --extended --octal-permissions'

alias n="nvim"


# Deferred initialization - runs after prompt
function _deferred_init() {
    # Completion system - deferred and cached
    autoload -Uz compinit
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "$ZDOTDIR/.zsh/cache"
    
    # Run full compinit only if dump is >24h old or missing
    if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
        compinit -d "$ZDOTDIR/.zcompdump"
    else
        compinit -C -d "$ZDOTDIR/.zcompdump"
    fi
    
    # Compile compdump for faster loading
    [[ "$ZDOTDIR/.zcompdump" -nt "$ZDOTDIR/.zcompdump.zwc" ]] && \
        zcompile "$ZDOTDIR/.zcompdump"
    
    # Other deferred initializations
    compdef eza=ls
    eval "$(zoxide init zsh)"

    }

# Schedule deferred init
zsh-defer _deferred_init

# Starship prompt (keep synchronous for instant prompt)
# eval "$(starship init zsh)"
# Replace synchronous starship with instant prompt
eval "$(starship init zsh --print-full-init)"

# Compile .zshrc for faster loading
[[ ! -f $ZDOTDIR/.zshrc.zwc ]] || [[ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]] && zcompile $ZDOTDIR/.zshrc

# Uncomment for profiling only
# zprof

# bun completions
# PROMPT='%F{9}[%F{11}%n%F{10}@%F{12}%m %F{13}%~%F{9}]%f$ '

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
