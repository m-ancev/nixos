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
  };
}
