{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        hephaestus = lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration/hephaestus.nix
            ./system-configuration/configuration.nix
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
        orpheus = lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration/orpheus.nix
            ./system-configuration/orpheus.nix
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager = {
            #     useGlobalPkgs = true;
            #     useUserPackages = true;
            #     users.yusu = import ./home-manager/hephaestus.nix;
            #   };
            # }
          ];
        };
      };
    };
}
