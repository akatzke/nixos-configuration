{ config, pkgs, age, ... }:

let
  user = "yusu";
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
  flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" "--update-input" "agenix" "--update-input" "nix-index-database" "--update-input" "nix-doom-emacs" ];
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

services.syncthing.devices = import ../syncthing/devices.nix;

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

}
