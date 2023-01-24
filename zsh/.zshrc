export PATH=/usr/local/texlive/2022/bin/x86_64-darwin:${PATH}
export PATH=/usr/local/sbin:${PATH}
export PATH=$HOME/.cargo/bin:${PATH}
export PATH=$HOME/.poetry/env:${PATH}
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:${MANPATH}
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:${INFOPATH}
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export XDG_CONFIG_HOME=~/.config
export JDTLS_HOME=~/.local/share/nvim/lsp_servers/jdtls
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc
export EDITOR=nvim

alias ..="cd .."
alias ssh="env TERM=xterm ssh"
alias ll="exa -al"
alias nv="nvim"
alias bu="aud && sudo tlmgr update -all -self --reinstall-forcibly-removed || true && brew update || true && brew upgrade  || true && brew upgrade --cask  || true && brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest  || true && brew cleanup  || true && pip-review --auto  || true && rustup update stable"
alias gpp="g++ main.cc && ./a.out"
alias aud="sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"
alias acs="acc s -s -- -y"
alias dt='time_stamp=$(date +%Y-%m-%d\ %H:%M:%S%z) && sed -i "" "s/date/$time_stamp/"'
alias cac="cargo compete"

gpgconf --launch gpg-agent
eval "$(starship init zsh)"
