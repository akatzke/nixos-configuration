{ config, pkgs, ... }:

let user = "yusu";
in {
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelModules = [
    "kvm-intel"
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
  ];
  # Make some extra kernel modules available to NixOS
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];
  
  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
}
