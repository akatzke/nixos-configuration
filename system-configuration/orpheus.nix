{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

networking.hostName = "orpheus"; # Define your hostname.

system.stateVersion = "22.11"; # Did you read the comment?

boot.initrd.secrets = {
  "/crypto_keyfile.bin" = null;
};

services.xserver.displayManager.defaultSession = "plasmawayland";

services.xserver = {
  layout = "us";
  xkbVariant = "dvp";
};

services.xserver.libinput.enable = true;

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 60d";
};

}
