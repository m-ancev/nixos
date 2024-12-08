{ config, pkgs, ... }:
{
  imports = [];

  home.username = "ma";
  home.homeDirectory = "/home/ma";

  home.file = {
    ".config/sway/config".source = ./config/sway/config;

    ".config/mako/config".source = ./config/mako/config;

    ".config/waybar".source = ./config/waybar;

    ".config/tofi/config".source = ./config/tofi/config;

    ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;

    ".config/nvim".source = ./config/nvim;

    ".tmux.conf".source = ./config/tmux/.tmux.conf;

    ".bashrc".source = ./config/bash/.bashrc;

    ".bash_profile".source = ./config/bash/.bash_profile;

    "wallpapers/".source = ./config/wallpapers;
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
