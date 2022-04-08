set PATH 	/usr/local/texlive/2022/bin/x86_64-darwin $PATH
set PATH        $HOME/.cargo/bin $PATH
set MANPATH 	/usr/local/texlive/2022/texmf-dist/doc/man $MANPATH
set INFOPATH 	/usr/local/texlive/2022/texmf-dist/doc/info $INFOPATH
set -g -x GPG_TTY (tty)
set -g -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# TeX
starship init fish | source
set -x fish_user_paths /Library/TeX/texbin $fish_user_paths
alias ssh "env TERM=xterm ssh"
alias ll "exa -al"
alias nv "nvim"
alias bu "sudo tlmgr update -all -self --reinstall-forcibly-removed && brew update && brew upgrade && brew upgrade --cask && pip list -o --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U pip && rustup update stable"
alias gpp "g++ main.cc && ./a.out"   
alias aud "sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"  
alias acs "acc s -s -- -y"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
gpgconf --launch gpg-agent

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/loishi/google-cloud-sdk/path.fish.inc' ]; . '/Users/loishi/google-cloud-sdk/path.fish.inc'; end
