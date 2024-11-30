{ config, pkgs, inputs, ... }:

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

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vlc
    jq
    dzen2
    qbittorrent
    lm_sensors
    brave
    killall
    libnotify
    libreoffice
    discord-canary
    waybar
    nil # language server
    gnome-system-monitor
    home-manager
    cargo
    xfce.mousepad
    adwaita-icon-theme
    mullvad-vpn
    neovim
    wget
    git
    firefox
    kitty
    tldr
    keepassxc
    obsidian
    syncthing
    unzip
    ripgrep
    htop
    btop
    tmux
    thunderbird
    lazygit
    tree
    tofi
    iwd
    fzf
    sublime-merge
    nautilus
    udiskie
    python3
    lua
    lua-language-server
    tree-sitter
    fd
    gnumake
    gcc
    luajitPackages.luarocks
    python311Packages.pip
    nodejs_22
    grim
    slurp
    wl-clipboard
    mako
    swaylock-effects
    pavucontrol
    pamixer
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

  # Needed for an app idk yet
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

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
  };


  services.gnome.gnome-keyring.enable = true;
  
  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
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
  fonts.packages = with pkgs; [ 
    jetbrains-mono 
  ];

  system.stateVersion = "24.05";
}
