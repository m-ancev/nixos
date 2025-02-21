{ pkgs, inputs, ... }:

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
      cbonsai # terminal bonsai tree
      angular-language-server # angularls
      bat # replacement for cat
      zig # latest stable release of zig
      ghostty # terminal
      eog # gnome image viewer
      hypridle # idle functionality for hyprland
      hyprlock # lock screen for hyprland
      hyprsunset # bluelight filter for hyprland
      hyprpolkitagent # sudo rights for gui for hyprland
      kdePackages.xwaylandvideobridge # xwayland compatibility
      clipse # clipboard history
      hyprpaper # wallpapers for hyprland
      nwg-look # gnome theming
      yazi # terminal file explorer
      typescript-language-server # ts_ls
      docker-compose
      meld # diff viewer
      fastfetch # terminal fetch
      iwgtk # GUI for iwd (Wi-Fi daemon)
      amberol # music player
      playerctl # media players via the command line (for media keys in sway/hyprland)
      wayland-utils # Utilities for Wayland (like wayland-info, etc.)
      celluloid # GUI for MPV (GNOME-based minimal media player)
      zathura # lightweight PDF (and other formats) viewer
      swayimg # image viewer for Wayland
      baobab # Disk usage analyzer (GNOME app)
      gnome-tweaks # adjust GNOME desktop settings
      libsForQt5.qt5ct # Qt5 configuration tool (to set themes, fonts, etc.)
      gnome-themes-extra # Additional GNOME themes (icons, UI themes)
      vlc # multimedia player
      jq # Command-line JSON processor
      qbittorrent # BitTorrent client
      lm_sensors # monitoring CPU/GPU temperatures, fan speeds, etc.
      killall # Command-line tool to terminate processes by name
      libnotify # Library for sending desktop notifications
      libreoffice # office suite (writer, calc, impress, etc.)
      discord-canary # Experimental/preview version of Discord
      waybar # Wayland bar
      nil # Language server NIL
      gnome-system-monitor # System monitoring GUI tool (resources, processes)
      home-manager # Nix-based user configuration tool (manages dotfiles and user packages)
      cargo # Rust package manager and build tool
      xfce.mousepad # graphical text editor
      adwaita-icon-theme # Default GNOME icon theme
      mullvad-vpn # VPN client
      neovim
      wget # Command-line tool for retrieving files from the web
      git
      firefox
      kitty
      tldr # Simplified and community-driven man pages
      keepassxc
      unzip # Extracts files from ZIP archives
      ripgrep # Fast command-line search tool (like grep, but faster)
      btop # A resource monitor with a modern, colorful UI (CPU, RAM, etc.)
      tmux
      thunderbird
      lazygit # Terminal UI for git commands
      tree # Displays directory trees in the terminal
      tofi # A minimalistic application launcher for Wayland
      iwd # iNet Wireless Daemon for managing Wi-Fi on Linux
      fzf # Command-line fuzzy finder
      sublime-merge # A GUI Git client
      nautilus # GNOME’s default file manager
      udiskie # Automounter for removable media in Linux
      lua # Lua scripting language interpreter
      lua-language-server # Language server for Lua (code completion, linting)
      luajitPackages.luarocks # Package manager for Lua modules (with LuaJIT support)
      tree-sitter # Parser generator tool and incremental parsing library
      fd # User-friendly alternative to ‘find’ (faster and easier syntax)
      gnumake # Tool for controlling the generation of executables (Make)
      gcc # GNU C/C++ compiler
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
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; 

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

  # Keyboard
  services.xserver.xkb.layout = "us,de";

  # Sound
  services.pipewire = {
    enable = true;
    # alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  # hardware.alsa.enablePersistence = true;

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
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers" "docker" ];
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
  # programs.sway = {
  #   enable = true;
  #   package = pkgs.swayfx;
  #   wrapperFeatures.gtk = true;
  # };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Display Manager
  services.displayManager = {
    enable = true;
    ly.enable = true;
    defaultSession = "hyprland";
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Docker
  virtualisation.docker.enable = true;

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
