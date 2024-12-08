# variables
export EDITOR='nvim'
export TERM='kitty'

# aliases
alias conf='nvim /home/$USER/nixos/'
alias esudo='sudo -Es'
alias nv=nvim
alias reb='pushd /home/ma/nixos/ && sudo nixos-rebuild switch --flake . && popd'
alias tm=tmux

# terminal prompt
if [ "$EUID" -eq 0 ]; then
    export PS1="\[\e[31m\]\n> \[\e[0m\]"
else
    export PS1="\[\e[37m\]\n> \[\e[0m\]"
fi

