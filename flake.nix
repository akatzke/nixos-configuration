{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, home-manager, agenix }: {
    nixosConfigurations = {
      hephaestus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          ./hardware-configuration/hephaestus.nix
          ./system-configuration/hephaestus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.yusu = import ./home-manager/hephaestus.nix;
            };
          }
        ];
      };
      orpheus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          ./hardware-configuration/orpheus.nix
          ./system-configuration/orpheus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.yusu = import ./home-manager/orpheus.nix;
            };
          }
        ];
      };
      sisyphus = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          agenix.nixosModules.default
          ./hardware-configuration/sisyphus.nix
          ./system-configuration/sisyphus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.yusu = import ./home-manager/sisyphus.nix;
            };
          }
        ];
      };
    };
  };
}
