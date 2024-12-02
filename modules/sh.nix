{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      reb = "pushd /home/ma/nixos/ && sudo nixos-rebuild switch --flake . && popd";
      conf = "nvim /home/ma/nixos/";
      nv = "nvim";
      tm = "tmux";
      esudo = "sudo -Es";
    };
    initExtra = ''
      if [ "$EUID" -eq 0 ]; then
          export PS1="\[\e[31m\]\n> \[\e[0m\]"
      else
          export PS1="\[\e[37m\]\n> \[\e[0m\]"
      fi
    '';
  };
}
