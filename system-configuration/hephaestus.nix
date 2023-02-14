{ config, pkgs, ... }:

let user = "yusu";
in {
  networking.hostName = "hephaestus"; # Define your hostname.
  system.stateVersion = "22.05"; # Did you read the comment?
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
}
