{ config, pkgs, age, ... }:

let
  user = "yusu";
  system = "aarch64-linux";
in {
  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  networking = {
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Enable networking
    networkmanager.enable = true;
  };
  
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  networking.firewall = {
    enable = true;
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  
  # Select internationalization properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS =        "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT =    "de_DE.utf8";
    LC_MONETARY =       "de_DE.utf8";
    LC_NAME =           "de_DE.utf8";
    LC_NUMERIC =        "en_US.utf8";
    LC_PAPER =          "de_DE.utf8";
    LC_TELEPHONE =      "de_DE.utf8";
    LC_TIME =           "de_DE.utf8";
  };
  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };
  fonts.fonts = with pkgs; [
    open-sans
    ubuntu_font_family
    (nerdfonts.override { fonts = [
        "FiraCode"
        "UbuntuMono"
    ]; })
  ];
  nix.settings.auto-optimise-store = true;
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
    flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" "--commit-lock-file"];
  };
  boot = {
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "75%";
  };
  services.syncthing = {
    enable = true;
    dataDir = "/home/${user}/.syncthing";
    configDir = "/home/${user}/.config/syncthing";
    user = "${user}";
    group = "users";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    openDefaultPorts = true;    # open the default ports in the firewall
  };
  services.syncthing.devices =
    {
      "hephaestus" = {
        id = "3ES4PVE-5VIXFJK-LRUWO6V-R5DXQ2Z-7VDELSG-7UTJH3J-P7FBO5F-7UCB6QY";
      };
      "orpheus" = {
        id = "6T46LZ2-G5V6YYP-2G5E2ZJ-BRPO64H-RXXCIGW-LZ3LYGT-5JME3V3-MZDRNA2";
      };
      "sisyphus" = {
        id = "CAR66DF-5W4XF3B-SJ4RGU2-ACLQYWF-L733V3A-FSWG2TB-FYA7YWK-OFEBIQS";
      };
      "jonas phone" = {
        id = "2PTXUAT-RQ2QVB3-NLFJMWP-LK6G4OU-GLDZGOI-RRBQOF5-D5RB37U-3GDCWAP";
      };
      "anna-lena phone" = {
        id = "2O33IW4-NXO3FAV-JJSKNUX-65YLX3S-QOJI3PZ-WX2OE73-2725IHT-WDV73AY";
      };
      "athena" = {
        id = "FQINAD3-2T3IRLC-3PI4PVT-ITEZEYV-KEMLA7T-YAHBDKK-YQR7ZVL-FKK4AQU";
      };
    }
  ;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBaF8njhPcA0yTR2dqMPiQ2I1GkYENwSqFLLM9CZukgZoOa9obTBJtiI++bQl0spK038dIBHT1GvhtbAe+u33k7BYNQB00QMk197PHoixri6Z6/SPjwKZoBZyn/CY8iUDWjK5m/hyIC+ThAT77FAy7QV4EVWtvEmZfRf3ILy3M6xALAwSWRq+eG/eDdn5nTRlZjmzccf3qGDKFAHCGhIGOsRPUwQm6rp04oUOr206cuh5PtOZMOlWc4VgH1DG2SGwdVAyUUiUAeHeDug4IuByhBUJcU0SNbCDlzSnNJk8FXG7x/tikmQDBW1uVDHXHTEP0MFR2QEj0ZY8hkgzhUzFNs6pnlg5FY1OYjJl9G2bE0Ez3zpyxnQPzRc06oA0c1vB5pSlI5Ya9HmcMObOOghdvs/F3kCS0u81BHjYKnExIX+KqR/ueU25cQyPMd3MQKc1AUgNEtDO+8D4NPmySUk9HZNH4lLo0319UQGxzjjMzJdWvqogYiJRzYFpLDYG0JSc= yusu"
    ];
  };
  users.users.root.hashedPassword = "!";
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.git
    pkgs.git-crypt
  ];
  programs.fish.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
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
  swapDevices = [
    {
      device = "/mnt/HDD/swapfile";
      size = 8192;
    }
  ];
  services.syncthing.folders =
    let
      root = "/mnt/HDD/Syncthing";
      home = "${root}/Jonas";
    in {
      "Jonas/Aegis" = {
        path = "${home}/Aegis";
        devices = [ "jonas phone" "sisyphus" ];
        id = "lzruc-rgtex";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Aegis";
        };
      };
      "Jonas/Backup Fairphone" = {
        path = "${home}/Backup Fairphone";
        devices = [ "jonas phone" "sisyphus" ];
        id = "4nk8n-jejos";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Backup Fairphone";
        };
      };
      "Jonas/Books" = {
        path = "${home}/Books";
        devices = [ "hephaestus" "orpheus" "sisyphus" ];
        id = "Books";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Books";
        };
      };
      "Jonas/Documents" = {
        path = "${home}/Documents";
        devices = [ "hephaestus" "orpheus" "jonas phone" "sisyphus" ];
        id = "Documents";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Documents";
        };
      };
      "Jonas/Uni" = {
        path = "${home}/Uni";
        devices = [ "hephaestus" "orpheus" "sisyphus" ];
        id = "Uni";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Uni";
        };
      };
      "Jonas/Wallpaper" = {
        path = "${home}/Pictures/Wallpaper";
        devices = [ "hephaestus" "orpheus" "sisyphus" ];
        id = "gzwzv-kkn3v";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/Wallpaper";
        };
      };
      "Jonas/work" = {
        path = "${home}/work";
        devices = [ "hephaestus" "orpheus" "sisyphus" ];
        id = "ss29z-neacc";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/work";
        };
      };
      "Jonas/gtd" = {
        path = "${home}/gtd";
        devices = [ "hephaestus" "orpheus" "jonas phone" "sisyphus" ];
        id = "gtd";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/gtd";
        };
      };
      "Jonas/org-roam" = {
        path = "${home}/org-roam";
        devices = [ "hephaestus" "orpheus" "jonas phone" "sisyphus" ];
        id = "org-roam";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/org-roam";
        };
      };
      "Jonas/org" = { # Name of folder in Syncthing, also the folder ID
        path = "${home}/org"; # Which folder to add to Syncthing
        devices =
          [ "hephaestus" "orpheus" "sisyphus" ]; # Which devices to share the folder with
        id = "org"; # The unique identifier of the folder, which is
                    #  identical across all devices
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Jonas/org";
        };
      
      };
      "Photos" = {
        path = "${root}/Photos";
        devices = [ "jonas phone" "anna-lena phone" "sisyphus" ];
        id = "j7xt7-vtt1h";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/Photos";
        };
      };
      "ledger" = {
        path = "${root}/ledger";
        devices = [ "hephaestus" "orpheus" "athena" "sisyphus" ];
        id = "Ledger";
        versioning = {
          type = "staggered";
          params.versionsPath = "${root}/.syncthing_backup/ledger";
        };
      };
    }
  ;
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
  virtualisation.docker.enable = true;
}
