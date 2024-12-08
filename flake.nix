{
  description = "NixOS configuration flake for tower and laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
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
