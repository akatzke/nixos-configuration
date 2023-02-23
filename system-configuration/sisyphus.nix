{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

networking.hostName = "sisyphus"; # Define your hostname.

system.stateVersion = "22.11"; # Did you read the comment?

boot.loader = {
  timeout = 2;
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  # generic-extlinux-compatible.enable = true;
  raspberryPi = {
    enable = true;
    version = 4;
    firmwareConfig = ''
      boot_delay=1
    '';
  };
};

boot.kernelPackages = pkgs.linuxPackages_rpi4;

networking.firewall = {
  allowedTCPPorts = [
    # blocky
    53
    4000
    # nextcloud
    80
    443
    # NFS
    2049
  ];

  allowedUDPPorts = [
    # blocky
    53
  ];
};

services.xserver = {
  layout = "us";
};

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 14d";
};

fileSystems."/mnt/HDD" = {
  device = "/dev/sda1";
  fsType = "auto";
  options = [ "defaults" "x-systemd.automount" "noauto" ];
};

fileSystems."/srv/nfs/Media" = {
  device = "/mnt/HDD/Media";
  options = [ "bind" ];
};

swapDevices = [
  {
    device = "/mnt/HDD/swapfile";
    size = 8192;
  }
];

services.syncthing.folders = import ../syncthing/folders-sisyphus.nix;

services.getty.autologinUser = "${user}";

age.secrets.nextcloud = {
  file = ../secrets/nextcloud.age;
  owner = "nextcloud";
  group = "nextcloud";
};

services.jellyfin = {
  inherit user;
  enable = true;
  openFirewall = true;
};

services.blocky = {
  enable = true;

  settings = {
    upstream = {
      default = [
        "dot.ffmuc.net"
        "dns.digitale-gesellschaft.ch"
        "unfiltered.adguard-dns.com"
        "doh.mullvad.net"
        "dns.njal.la"
      ];
    };
    upstreamTimeout = "2s";
    startVerifyUpstream = true;

    port = 53;
    httpPort = 4000;

    connectIPVersion = "dual";

    blocking = {
      blackLists = {
        "ads" = [
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_Base/filter.txt"
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_17_TrackParam/filter.txt"
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_4_Social/filter.txt"
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_14_Annoyances/filter.txt"
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_6_German/filter.txt"
          "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_11_Mobile/filter.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/annoyances.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/badware.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/privacy.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/quick-fixes.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/resource-abuse.txt"
          "https://github.com/uBlockOrigin/uAssets/blob/master/filters/unbreak.txt"
        ];
      };
      whiteLists = {
        "ads" = [
          ../blocky/whitelist.txt
        ];
      };
      clientGroupsBlock = {
        default = [
          "ads"
        ];
      };

      blockType = "zeroIP";
    };

    caching = {
      prefetching = true;
    };

    queryLog = {
      type = "csv";
      target = "/tmp";
    };
  };
};

services.nextcloud = {
  enable = true;
  hostName = "sisyphus";
  config = {
    dbtype = "pgsql";
    dbuser = "nextcloud";
    dbhost = "/run/postgresql";
    dbname = "nextcloud";
    adminpassFile = config.age.secrets.nextcloud.path;
    adminuser = "root";
    extraTrustedDomains = ["hephaestus" "192.168.178.*"];
  };
  home = "/mnt/HDD/nextcloud";
};

services.postgresql = {
  enable = true;
  ensureDatabases = [ "nextcloud" ];
  ensureUsers = [
    { name = "nextcloud";
      ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
    }
  ];
};

systemd.services."nextcloud-setup" = {
  requires = ["postgresql.service"];
  after = ["postgresql.service"];
};

services.nfs.server = {
  enable = true;
  exports = ''
    /srv/nfs/Media      192.168.178.0/24(insecure,rw,sync,no_subtree_check,no_all_squash,root_squash)
  '';
};

virtualisation.docker.enable = true;

}
