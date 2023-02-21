{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, nix-index-database }: {
    nixosConfigurations = {
      hephaestus = let system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hardware-configuration/hephaestus.nix
          ./system-configuration/hephaestus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.yusu = import ./home-manager/hephaestus.nix;
              sharedModules = [ nix-index-database.nixosModules.nix-index ];
            };
          }
          agenix.nixosModules.default
          {
            environment.systemPackages =
              [ agenix.packages."${system}".default ];
          }
        ];
      };
      orpheus = let system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
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
          agenix.nixosModules.default
          {
            environment.systemPackages =
              [ agenix.packages."${system}".default ];
          }
        ];
      };
      sisyphus = let system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
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
          agenix.nixosModules.default
          {
            environment.systemPackages =
              [ agenix.packages."${system}".default ];
          }
        ];
      };
    };
  };
}
