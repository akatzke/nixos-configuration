{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

boot.kernelModules = [
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

networking.firewall = {
  allowedTCPPortRanges = [
    # GS-/KDE-Connect
    { from = 1714; to = 1764; }
  ];

  allowedUDPPortRanges = [
    # GS-/KDE-Connect
    { from = 1714; to = 1764; }
  ];
};

services.xserver = {
  # Use the X11 Display Server
  enable = true;
  # Enable Desktop Environments
  desktopManager = {
    gnome.enable = false;
    plasma5.enable = true;
  };
  # Enable Window Managers
  windowManager = {
    qtile.enable = true;
  };
  # Set and configure login manager
  displayManager = {
    sddm = {
      enable = false;
    };
    lightdm.enable = true;
    autoLogin = {
      user = "${user}";
    };
  };
};

fileSystems."/mnt/Media" = {
  device = "192.168.178.74:/srv/nfs/Media";
  fsType = "nfs";
  options = [ "defaults" "x-systemd.automount" "noauto" "timeo=900" "retrans=5" "_netdev" ];
};

services.syncthing.folders = import ../syncthing/folders-desktop.nix;

services.openssh = {
  passwordAuthentication = false;
  kbdInteractiveAuthentication = false;
  openFirewall = false;
};

age.secrets.gmail = {
  file = ../secrets/gmail.age;
  owner = "${user}";
};
age.secrets.outlook = {
  file = ../secrets/outlook.age;
  owner = "${user}";
};

age.secrets.authinfo = {
  file = ../secrets/authinfo.age;
  owner = user;
};

# Enable CUPS to print documents.
services.printing = {
  enable = true;
};

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

hardware.bluetooth.enable = true;
services.blueman.enable = true;

services.flatpak.enable = true;
xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.libsForQt5.xdg-desktop-portal-kde ];
};

services.languagetool = {
  enable = true;
};

}
