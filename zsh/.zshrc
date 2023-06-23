typeset -U path PATH
path=(/opt/homebrew/sbin /opt/homebrew/bin/ ~/.cargo/bin $path)
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
alias la="lsd -a"
alias nv="nvim"
alias bu="brew update || true && brew upgrade || true && brew upgrade --cask || true && brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest || true && brew cleanup || true && tldr -u || true && rustup update stable"
alias gpp="g++ main.cc && ./a.out"
alias aud="sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"
alias acs="acc s -s -- -y"
alias dt='time_stamp=$(date +%Y-%m-%d\ %H:%M:%S%z) && sed -i "" "s/date/$time_stamp/"'
alias cac="cargo compete"

gpgconf --launch gpg-agent
eval "$(starship init zsh)"
