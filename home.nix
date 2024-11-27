{ config, pkgs, ... }:
{
  imports = [
    ./modules/sh.nix
  ];

  home.username = "ma";
  home.homeDirectory = "/home/ma";

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
  };

  home.file = {
    ".config/sway/config".source = ./config/sway/config;

    ".config/tofi/config".source = ./config/tofi/config;

    ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;

    ".config/nvim".source = ./config/nvim;

    ".tmux.conf".source = ./config/tmux/.tmux.conf;
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
