{ config, pkgs, ... }:

let user = "yusu";
in {
  networking.hostName = "hephaestus"; # Define your hostname.
  system.stateVersion = "22.05"; # Did you read the comment?
  services.xserver.displayManager.defaultSession = "none+qtile";
  services.xserver.displayManager.defaultSession = "Plasma (Wayland)";
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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;       # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false;  # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode = {
    enable = true;
  };
  services.udev.packages = [
    pkgs.qmk-udev-rules
  ];
}
