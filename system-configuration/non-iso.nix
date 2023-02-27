{ config, pkgs, age, ... }:

let
  user = "yusu";
in {

networking = {
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networkmanager.enable = true;
};

users.users.root.hashedPassword = "!";

services.openssh.permitRootLogin = "no";

}
