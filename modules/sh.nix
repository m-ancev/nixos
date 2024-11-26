{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      reb = "cd /home/ma/nixos/ && sudo nixos-rebuild switch --flake .";
      conf = "nvim /home/ma/nixos/";
      nv = "nvim";
      tm = "tmux";
      esudo = "sudo -Es";
    };
  };
}
