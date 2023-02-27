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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, agenix, nix-index-database
    , nix-doom-emacs, nixos-generators, nixos-hardware, ... }: {
      nixosConfigurations = {
        hephaestus = let
          system = "x86_64-linux";
          hostName = "hephaestus";
        in nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

            ./hardware-configuration/${hostName}.nix
            ./system-configuration/core.nix
            ./system-configuration/non-iso.nix
            ./system-configuration/uefi-boot.nix
            ./system-configuration/desktop.nix
            ./system-configuration/${hostName}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: {
                  imports = [
                    ./home-manager/core.nix
                    ./home-manager/desktop.nix
                    ./home-manager/${hostName}.nix
                  ];
                };
                sharedModules = [
                  nix-index-database.nixosModules.nix-index
                  nix-doom-emacs.hmModule
                ];
              };
            }
            agenix.nixosModules.default
            {
              environment.systemPackages =
                [ agenix.packages."${system}".default ];
            }
          ];
        };
        orpheus = let
          system = "x86_64-linux";
          hostName = "orpheus";
        in nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.common-gpu-nvidia

            ./hardware-configuration/${hostName}.nix
            ./system-configuration/core.nix
            ./system-configuration/non-iso.nix
            ./system-configuration/uefi-boot.nix
            ./system-configuration/desktop.nix
            ./system-configuration/${hostName}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: {
                  imports = [
                    ./home-manager/core.nix
                    ./home-manager/desktop.nix
                    ./home-manager/${hostName}.nix
                  ];
                };
                sharedModules = [
                  nix-index-database.nixosModules.nix-index
                  nix-doom-emacs.hmModule
                ];
              };
            }
            agenix.nixosModules.default
            {
              environment.systemPackages =
                [ agenix.packages."${system}".default ];
            }
          ];
        };
        sisyphus = let
          system = "aarch64-linux";
          hostName = "sisyphus";
        in nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration/${hostName}.nix
            nixos-hardware.nixosModules.raspberry-pi-4
            ./system-configuration/core.nix
            ./system-configuration/non-iso.nix
            ./system-configuration/${hostName}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: {
                  imports =
                    [ ./home-manager/core.nix ./home-manager/${hostName}.nix ];
                };
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
      };

      packages.x86_64-linux = let system = "x86_64-linux";
      in {
        desktop-iso = nixos-generators.nixosGenerate {
          inherit system;
          modules = [
            ./system-configuration/core.nix
            ./system-configuration/desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yusu = { ... }: {
                  imports =
                    [ ./home-manager/core.nix ./home-manager/desktop.nix ];
                  home.stateVersion = "22.11";
                };
                sharedModules = [
                  nix-index-database.nixosModules.nix-index
                  nix-doom-emacs.hmModule
                ];
              };
            }
            agenix.nixosModules.default
            {
              environment.systemPackages =
                [ agenix.packages."${system}".default ];
            }
          ];
          format = "install-iso";
        };
      };
    };
}
