{ config, pkgs, ... }:
{
  imports = [];

  home.username = "ma";
  home.homeDirectory = "/home/ma";

  home.file = {
    ".config/sway/config".source = ./config/sway/config;

    ".config/waybar".source = ./config/waybar;

    ".config/mako/config".source = ../common/mako/config;

    ".config/tofi/config".source = ../common/tofi/config;

    ".config/kitty/kitty.conf".source = ../common/kitty/kitty.conf;

    ".config/nvim".source = ../common/nvim;

    ".tmux.conf".source = ../common/tmux/.tmux.conf;

    ".bashrc".source = ../common/bash/.bashrc;

    ".bash_profile".source = ../common/bash/.bash_profile;

    "wallpapers/".source = ../common/wallpapers;
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
