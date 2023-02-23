let
  root = "/home/yusu";
  home = "/home/yusu";
in  {
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
