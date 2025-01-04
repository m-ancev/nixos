{  pkgs, inputs, ... }:

let
  user = "ma";
in

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
      fastfetch
      iwgtk # GUI front-end for iwd (Wi-Fi daemon)
      amberol # Simple, modern, and opinionated music player
      playerctl # Control media players via the command line (for media keys in sway)
      wayland-utils # Utilities for Wayland (like wayland-info, etc.)
      celluloid # GUI front-end for MPV (GNOME-based minimal media player)
      zathura # Minimal and lightweight PDF (and other formats) viewer
      swayimg # Minimal image viewer for Wayland/sway
      baobab # Disk usage analyzer (GNOME app)
      vlc # Versatile, cross-platform multimedia player
      jq # Command-line JSON processor
      qbittorrent # BitTorrent client with a nice GUI
      lm_sensors # Tools for monitoring CPU/GPU temperatures, fan speeds, etc.
      brave # Privacy-focused web browser based on Chromium
      killall # Command-line tool to terminate processes by name
      libnotify # Library for sending desktop notifications
      libreoffice # Full-featured office suite (writer, calc, impress, etc.)
      discord-canary # Experimental/preview version of the Discord chat client
      waybar # Highly customizable Wayland bar (e.g. for sway)
      nil # Language server for the NIL programming language (if applicable)
      gnome-system-monitor # System monitoring GUI tool (resources, processes)
      home-manager # Nix-based user configuration tool (manages dotfiles and user packages)
      cargo # Rust package manager and build tool
      xfce.mousepad # Lightweight graphical text editor for the Xfce desktop
      adwaita-icon-theme # Default GNOME icon theme
      mullvad-vpn # VPN client for Mullvad VPN service
      neovim # Modernized, Vim-based text editor
      wget # Command-line tool for retrieving files from the web
      git # Distributed version control system
      firefox # Mozilla’s open-source web browser
      kitty # Fast, GPU-accelerated terminal emulator
      tldr # Simplified and community-driven man pages
      keepassxc # Cross-platform password manager (KeePass-compatible)
      obsidian # Note-taking and knowledge base app with Markdown
      unzip # Extracts files from ZIP archives
      ripgrep # Fast command-line search tool (like grep, but faster)
      btop # A resource monitor with a modern, colorful UI (CPU, RAM, etc.)
      tmux # Terminal multiplexer, allows multiple sessions/panes in one terminal
      thunderbird # Mozilla’s email, news, and calendar client
      lazygit # Terminal UI for git commands
      tree # Displays directory trees in the terminal
      tofi # A minimalistic application launcher for Wayland
      iwd # iNet Wireless Daemon for managing Wi-Fi on Linux
      fzf # Command-line fuzzy finder (useful for interactive searching)
      sublime-merge # A GUI Git client (by the makers of Sublime Text)
      nautilus # GNOME’s default file manager
      udiskie # Automounter for removable media in Linux
      lua # Lua scripting language interpreter
      lua-language-server # Language server for Lua (code completion, linting)
      tree-sitter # Parser generator tool and incremental parsing library
      fd # User-friendly alternative to ‘find’ (faster and easier syntax)
      gnumake # Tool for controlling the generation of executables (Make)
      gcc # GNU C/C++ compiler
      luajitPackages.luarocks # Package manager for Lua modules (with LuaJIT support)
      python312 # Python 3 interpreter
      python312Packages.pip
      python312Packages.virtualenv
      python312Packages.jedi-language-server
      nodejs_22 # JavaScript runtime (Node.js) version 22
      grim # Screenshot utility for Wayland
      slurp # Select a region in a Wayland compositor (used with grim)
      wl-clipboard # Command-line copy/paste utilities for Wayland
      mako # Wayland notification daemon
      swaylock-effects # A customizable fork of swaylock for locking the screen
      swayidle
      pavucontrol # GUI volume control for PulseAudio
      pamixer # Command-line tool to control PulseAudio volumes
  ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.${user} = import ./home.nix;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.wireless.iwd.enable = true;
  networking.useDHCP = true;
  services.mullvad-vpn.enable = true;
  # networking.networkmanager.enable = true: # Fallback in case of issues
 
  # Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  hardware.alsa.enablePersistence = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable udisks2 for auto-mounting
  services.udisks2.enable = true;

  # Automatic garbage collection and flakes
  nix = {
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [ 
        "nix-command" 
        "flakes" 
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };  
  };

  # Automatically upgrade when rebuilding using channel
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Define a user account.
  users.users.${user} = {
    isNormalUser = true;
    description = "ma";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.unstable = true;

  environment.variables = {
    XCURSOR_THEME = "adwaita-icon-theme";
    XCURSOR_SIZE = "13";
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  
  # Sway
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  # Font
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  system.stateVersion = "24.05";
}
