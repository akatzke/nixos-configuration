{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

boot.loader = {
  timeout = 2;

  # use UEFI
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = false;
  efi.efiSysMountPoint = "/boot/efi";
};

}
