{ config, pkgs, ... }:

let
  user = "yusu";
  system = "x86_64-linux";
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
    flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" ];
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
  services.syncthing = {
    devices = import ../.secrets/syncthing/devices.nix;
    folders = import ../.secrets/syncthing/folders_desktop.nix;
  };
  services.openssh = {
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    openFirewall = false;
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
  networking.hostName = "orpheus"; # Define your hostname.
  system.stateVersion = "22.11"; # Did you read the comment?
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
