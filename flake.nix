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
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, nix-index-database, nix-doom-emacs }: {
    nixosConfigurations = {
      hephaestus = let
        system = "x86_64-linux";
        hostname = "hephaestus";
      in nixpkgs.lib.nixosSystem
        {
          inherit system;
          modules = [
            ./hardware-configuration/${hostname}.nix
            ./system-configuration/${hostname}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: { imports = [ ./home-manager/${hostname}.nix ]; };
                sharedModules =
                  [ nix-index-database.nixosModules.nix-index nix-doom-emacs.hmModule ];
              };
            }
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages."${system}".default ]; }
          ];
        }
      ;
      orpheus = let
        system = "x86_64-linux";
        hostname = "orpheus";
      in nixpkgs.lib.nixosSystem
        {
          inherit system;
          modules = [
            ./hardware-configuration/${hostname}.nix
            ./system-configuration/${hostname}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: { imports = [ ./home-manager/${hostname}.nix ]; };
                sharedModules =
                  [ nix-index-database.nixosModules.nix-index nix-doom-emacs.hmModule ];
              };
            }
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages."${system}".default ]; }
          ];
        }
      ;
      sisyphus = let
        system = "aarch64-linux";
        hostname = "sisyphus";
      in nixpkgs.lib.nixosSystem
        {
          inherit system;
          modules = [
            ./hardware-configuration/${hostname}.nix
            ./system-configuration/${hostname}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: { imports = [ ./home-manager/${hostname}.nix ]; };
                sharedModules =
                  [ nix-index-database.nixosModules.nix-index nix-doom-emacs.hmModule ];
              };
            }
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages."${system}".default ]; }
          ];
        }
      ;
    };
  };
}
