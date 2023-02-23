{ osConfig, config, pkgs, ... }:
let
  user = "yusu";
  name = "Jonas Opitz";
in {

home.stateVersion = "22.05";

home.packages = [

pkgs.heroic
pkgs.gamescope
pkgs.yuzu-mainline
pkgs.prismlauncher
pkgs.protonup-ng

pkgs.yacreader
pkgs.transgui

];

}
