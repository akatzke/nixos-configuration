{ config, pkgs, ... }:

let user = "yusu";
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
    LC_ALL =            "en_US.utf8";
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
    overrideDevices = false;     # overrides any devices added or deleted through the WebUI
    overrideFolders = false;     # overrides any folders added or deleted through the WebUI
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
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  networking.hostName = "sisyphus"; # Define your hostname.
  system.stateVersion = "22.11"; # Did you read the comment?
  boot.loader = {
    timeout = 2;
    # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
    grub.enable = false;
    # Enables the generation of /boot/extlinux/extlinux.conf
    generic-extlinux-compatible.enable = true;
  };
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  virtualisation.docker.enable = true;
  services.getty.autologinUser = "${user}";
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    listenAddresses = [
      {
        addr = "192.168.178.1/24";
      }
    ];
  };
}
