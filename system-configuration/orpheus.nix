{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

networking.hostName = "orpheus"; # Define your hostname.

system.stateVersion = "22.11"; # Did you read the comment?

boot.loader = {
  timeout = 2;

  # use UEFI
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = false;
  efi.efiSysMountPoint = "/boot/efi";

  # use GRUB
  # grub = {
  #   enable = true;
  #   version = 2;
  #   device = "/dev/sda";
  #   theme = pkgs.nixos-grub2-theme;
  #   # whether to have grub probe for other devices to boot from (e.g. windows)
  #   useOSProber = false;
  # };
};

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
