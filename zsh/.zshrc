typeset -U path PATH
path=(/opt/homebrew/sbin /opt/homebrew/bin/ ~/.cargo/bin ~/x/git/monero/build/Darwin/master/release/bin .local/bin $path)
export PATH
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export XDG_CONFIG_HOME=~/.config
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc
export EDITOR=nvim

alias ..="cd .."
alias ssh="env TERM=xterm ssh"
alias ll="lsd -al"
alias npm="pnpm"
alias la="lsd -a"
alias nv="nvim"
alias bu="brew update || true && brew upgrade || true && brew upgrade --cask || true && brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest || true && brew cleanup || true && tldr -u || true && rustup update stable"
alias gpp="g++ main.cc && ./a.out"
alias aud="sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"
alias acs="acc s -s -- -y"
alias dt='time_stamp=$(date +%Y-%m-%d\ %H:%M:%S%z) && sed -i "" "s/date/$time_stamp/"'
alias cac="cargo compete"
alias sf="python3 ~/x/git/external-engine/example-provider.py --name M2 --token lip_SwDZuY2bmtNMgrfNw6oS --engine ~/x/git/Stockfish/src/stockfish --max-threads 8 --max-hash 15360 --default-depth 64 --keep-alive 10485760"

autoload -U colors 
colors

autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

setopt autocd

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$ZDOTDIR/.zsh_history

# History search
typeset -g -A key
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#797979"

# pnpm
export PNPM_HOME="/Users/loishi/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

gpgconf --launch gpg-agent
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
