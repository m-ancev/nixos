# variables
export EDITOR='nvim'
export TERM='kitty'

# aliases
alias rebt='pushd /home/$USER/nixos/ && sudo nixos-rebuild switch --flake .#tower && popd'
alias rebl='pushd /home/$USER/nixos/ && sudo nixos-rebuild switch --flake .#laptop && popd'
alias conf='nvim /home/$USER/nixos/'
alias esudo='sudo -Es'
alias ..='cd ..'
alias nv=nvim
alias tm=tmux

# terminal prompt
if [ "$EUID" -eq 0 ]; then
    export PS1="\[\e[31m\]\n> \[\e[0m\]"
else
    export PS1="\[\e[37m\]\n> \[\e[0m\]"
fi

