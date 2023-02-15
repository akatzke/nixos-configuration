{ config, pkgs, ... }:

let user = "yusu";
in {
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "sisyphus"; # Define your hostname.
  system.stateVersion = "22.11"; # Did you read the comment?
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
