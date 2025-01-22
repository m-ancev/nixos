{
  description = "NixOS configuration flake for tower and laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # virtualboxPkgs.url = "github:NixOS/nixpkgs/e4cef11b7889c3dd0ff200d8467f16c993f8b5e7";
  };
# virtualboxPkgs,
  outputs = { self, nixpkgs, home-manager,  ... }@inputs: 
  {
    nixosConfigurations = {
      # Configuration for Tower
      tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./tower/hardware-configuration.nix
          ./tower/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };

      # Configuration for Laptop
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./laptop/hardware-configuration.nix
          ./laptop/configuration.nix
          # {
          #   # Override the VirtualBox package used by the module
          #   nixpkgs.overlays = [
          #     (self: super: {
          #       virtualbox = virtualboxPkgs.legacyPackages.x86_64-linux.virtualbox;
          #     })
          #   ];
          # }
        ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      # Home Manager configuration for Tower
      towerUser = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./tower/home.nix ];
      };

      # Home Manager configuration for Laptop
      laptopUser = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./laptop/home.nix ];
      };
    };
  };
}
