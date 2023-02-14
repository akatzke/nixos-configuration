{ config, pkgs, ... }:

let user = "yusu";
in {
  networking.hostName = "orpheus"; # Define your hostname.
  system.stateVersion = "22.11"; # Did you read the comment?
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  services.xserver = {
    layout = "us";
    xkbVariant = "dvp";
  };
  services.xserver.libinput.enable = true;
}
