# variables
export EDITOR='nvim'
export TERM='kitty'
export NIXOS_OZONE_WL=1

# aliases
alias rebt='pushd /home/$USER/nixos/ && sudo nixos-rebuild switch --flake .#tower && popd'
alias rebl='pushd /home/$USER/nixos/ && sudo nixos-rebuild switch --flake .#laptop && popd'
alias conf='nvim /home/$USER/nixos/'
# sudo in interactive mode
alias esudo='sudo -Es'
alias s='sudo -Es'
alias f='yazi'
alias ..='cd ..'
alias nv=nvim
alias tm=tmux
alias e=exit

# terminal prompt
if [ "$EUID" -eq 0 ]; then
    export PS1="\n\[\e[31m\]\w\n> \[\e[0m\]"
else
    export PS1="\n\[\e[37m\]\w\n> \[\e[0m\]"
fi
