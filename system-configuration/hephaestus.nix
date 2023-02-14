{ config, pkgs, ... }:

let user = "yusu";
in {
  networking.hostName = "hephaestus"; # Define your hostname.
  system.stateVersion = "22.05"; # Did you read the comment?
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  fileSystems."/home" = {
    label = "home";
    fsType = "ext4";
    options = [ "defaults" ];
  };
  fileSystems."/mnt/HDD" = {
    label = "HDD";
    fsType = "ntfs";
    options = [ "defaults" "x-systemd.automount" "noauto" ];
  };
  services.udev.packages = [
    pkgs.qmk-udev-rules
  ];
}
