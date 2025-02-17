{ osConfig, config, pkgs, ... }:
let
  user = "yusu";
  name = "Jonas Opitz";
in {

home = {
  sessionPath = [
    "/home/${user}/.emacs.d/bin"
    "/home/${user}/.local/bin"
  ];
};

xdg.enable = true;
xdg.mimeApps = {
  enable = true;
  associations = {
    added = {
      "application/pdf"="okularApplication_pdf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "application/x-compressed-tar"="org.kde.dolphin.desktop";
      "inode/directory" = "org.kde.dolphin.desktop";
      "text/plain" = "emacsclient.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "x-scheme-handler/mid" = "thunderbird.desktop";
      "x-scheme-handler/http"="librewolf.desktop";
      "x-scheme-handler/https"="librewolf.desktop";
    };
  };
  defaultApplications = {
    "application/pdf"="okularApplication_pdf.desktop";
    "application/xhtml+xml"="librewolf.desktop";
    "application/zip"="org.kde.dolphin.desktop";
    "inode/directory"="org.kde.dolphin.desktop";
    "message/rfc822"="thunderbird.desktop";
    "x-scheme-handler/discord-712465656758665259"="discord.desktop";
    "x-scheme-handler/mailto"="thunderbird.desktop";
    "x-scheme-handler/mid"="thunderbird.desktop";
    "x-scheme-handler/msteams"="teams-for-linux.desktop";
    "x-scheme-handler/http"="librewolf.desktop";
    "x-scheme-handler/https"="librewolf.desktop";
  };
};

programs.alacritty = {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "Fira Code Nerd Font";
        style = "Retina";
      };
      bold = {
        family = "Fira Code Nerd Font";
        style = "Bold";
      };
      size = 11;
    };
    colors = {
      primary = {
        background = "0x242730";
        foreground = "0xbbc2cf";
      };
      normal = {
        black = "0x242730";
        red = "0xff6c6b";
        green = "0x98be65";
        yellow = "0xecbe7b";
        blue = "0x51afef";
        magenta = "0xc678dd";
        cyan = "0x46d9ff";
        white = "0xbbc2cf";
      };
    };
  };
};

programs.autorandr = {
  enable = true;
  profiles = {
    "three_sub_cloned" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "59.98";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "2560x726";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "2560x726";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "three_no_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          enable = false;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "three_only_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "59.98";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          enable = false;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "two_default" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        HDMI-0 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          enable = true;
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "74.99";
        };
        DVI-D-0 = {
          enable = true;
          crtc = 1;
          mode = "1920x1080";
          position = "2560x667";
          rate = "60.00";
        };
      };
    };
    "two_rotated_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "74.99";
          rotate = "left";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "1080x1285";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          enable = false;
        };
      };
    };
  };
};

programs.doom-emacs = {
  enable = true;
  doomPrivateDir = ../doom;
  doomPackageDir = pkgs.linkFarm "doom-packages" [
    # straight needs a (possibly empty) `config.el` file to build
    { name = "config.el"; path = pkgs.emptyFile; }
    { name = "init.el"; path = ../doom/init.el; }
    { name = "packages.el"; path = ../doom/packages.el; }
  ];

  # external dependencies that I don't want to install globally
  extraPackages = [
    # for the email client mu4e
    pkgs.mu
    pkgs.isync
  ];
  # the following elisp code is appended to [[file:doom/config.el][config.el]].
  # this is useful for setting paths to executables that are not globally installed
  # (i.e. the packages listed in extraPackages)
  extraConfig = ''
    (setq! auth-sources '("${osConfig.age.secrets.authinfo.path}"))
    (setq! mu4e-mu-binary "${pkgs.mu}/bin/mu")
  '';

  emacsPackagesOverlay = self: super: {
    org-media-note = self.trivialBuild {
      pname = "org-media-note";
      ename = "org-media-note";
      buildInputs = [ self.org-ref ];
      packageRequires = [  self.mpv self.pretty-hydra ];
      src = pkgs.fetchFromGitHub {
        owner = "yuchen-lea";
        repo = "org-media-note";
        rev = "dd458c3260530d1866eaa0cde4b1bb71c6f8cf0e";
        hash = "sha256-h/PtuhhhNEG77RBp3UvIeIwZu0iMP/MJJBo44LqhlRM=";
      };
    };
    org-fc = self.trivialBuild {
      pname = "org-fc";
      ename = "org-fc";
      packageRequires = [ self.hydra ];
      src = pkgs.fetchFromGitHub {
        owner = "l3kn";
        repo = "org-fc";
        rev = "973a16a9561f1ed2fd7e4c5c614b5e5d15715b12";
        hash = "sha256-UfAvlt+TzE8+zs5esb2CI/Z1WUbl3nNqCDkw7irXkh0=";
      };
    };
    salv = self.trivialBuild {
      pname = "salv";
      ename = "salv";
      src = pkgs.fetchFromGitHub {
        owner = "alphapapa";
        repo = "salv.el";
        rev = "4797f8d06a8a1a3b44e120b3ad6f6da557818ea1";
        hash = "sha256-MdS+m6NgAV8ewej1WDSlABu73tlZ2kidw25pV4DAlwI=";
      };
    };
    org-auto-tangle = self.trivialBuild {
      pname = "org-auto-tangle";
      ename = "org-auto-tangle";
      packageRequires = [ self.async self.cl-lib self.org ];
      src = pkgs.fetchFromGitHub {
        owner = "yilkalargaw";
        repo = "org-auto-tangle";
        rev = "817eabf902e759e96782bdc54d2dab36c4a2c5ab";
        hash = "sha256-xcNMlY+hYxFF9U9iiAEbUaQ9BY6jIxRc87lZDUqXfeU=";
      };
    };
  };
};

services.dunst = {
  enable = true;
};

accounts.email = {
  maildirBasePath = "/home/${user}/.mail";
  accounts = {
    Outlook = {
      address = "jonas.opitz@live.de";
      userName = "jonas.opitz@live.de";
      realName = "Jonas Opitz";
      primary = true;
      flavor = "plain";
      passwordCommand = "cat ${osConfig.age.secrets.outlook.path}";

      msmtp.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      mu.enable = true;
      thunderbird.enable = true;

      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp-mail.outlook.com";
        port = 587;
        tls.useStartTls = true;
      };
    };
  };
};

programs = {
  msmtp.enable = true;
  mbsync.enable = true;
};

services = {
  mbsync = {
    enable = false;
    preExec = "${pkgs.isync}/bin/mbsync -Ha";
    postExec = "${pkgs.mu}/bin/mu index -m /home/${user}/.mail";
  };
};

programs.librewolf = {
  enable = true;
};

programs.fish.interactiveShellInit = ''
  freshfetch
  # Emulates vim's cursor shape behavior
  # Set the normal and visual mode cursors to a block
  set fish_cursor_default block blink
  # Set the insert mode cursor to a line
  set fish_cursor_insert line blink
  # Set the replace mode cursor to an underscore
  set fish_cursor_replace_one underscore blink
  # The following variable can be used to configure cursor shape in
  # visual mode, but due to fish_cursor_default, is redundant here
  set fish_cursor_visual block blink
  set EDITOR devour emacsclient -c
  set VISUAL devour emacsclient -c
'';

services.gammastep = {
  enable = false;
  latitude  = 52.5;
  longitude = 13.4;
  temperature = {
    day   = 6500;
    night = 3500;
  };
  tray = true;
  settings = {
    general = {
      fade = 1;
      brigtness-day    = 1.0;
      brightness-night = 0.9;
      gamma-day   = 1.0;
      gamma-night = 0.9;
    };
  };
};

services.gpg-agent.pinentryFlavor = "qt";

services.kdeconnect = {
  enable = true;
  indicator = true;
};

programs.mangohud = {
  enable = true;
  enableSessionWide = false;
  settingsPerApplication = {
    mpv = {
      no_display = true;
    };
  };
};

programs.mpv = {
  enable = true;
};

programs.obs-studio = {
  enable = true;
};

services.picom = {
  enable = true;
  backend = "glx";
  vSync = true;
  opacityRules = [
    "95:class_g = 'Alacritty' && focused"
    "80:class_g = 'Alacritty' && !focused"
    "95:class_g = 'Emacs' && focused"
    "80:class_g = 'Emacs' && !focused"
    "95:class_g = 'TelegramDesktop' && focused"
    "80:class_g = 'TelegramDesktop' && !focused"
    "95:class_g = 'Slack' && focused"
    "80:class_g = 'Slack' && !focused"
    "95:class_g = 'Mattermost' && focused"
    "80:class_g = 'Mattermost' && !focused"
    "80:class_g = 'Rofi' && focused"
    "80:class_g = 'Rofi' && !focused"
    "95:class_g = 'Element' && focused"
    "80:class_g = 'Element' && !focused"
    "95:class_g = 'Signal' && focused"
    "80:class_g = 'Signal' && !focused"
    "95:class_g = 'Spotify' && focused"
    "80:class_g = 'Spotify' && !focused"
    "95:class_g = 'Anki' && focused"
    "80:class_g = 'Anki' && !focused"
  ];
};

xdg.configFile."qtile" = {
  source = ../qtile;
  recursive = true;
};

programs.rofi = {
  enable = true;
  font = "Fira Code Nerd Font 10";
  terminal = "alacritty";
  theme = "glue_pro_blue";
  cycle = true;
  extraConfig = {
    modi = "window,drun,ssh,combi";
    combi-modi = "window,drun,ssh";
    show-icons = true;
    icon-theme = "Nerd Icons";
    drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    disable-history = false;
    sidebar-mode = false;
  };
};

home.file.".vale.ini" = {
  text = ''
    StylesPath = ".vale"
    MinAlertLevel = suggestion # suggestion, warning or error
    
    # the file formats to use
    [*.{md,txt,org}]
    # List of styles to load.
    BasedOnStyles = proselint
  '';
};

home.file.".vale" = {
  source = pkgs.fetchFromGitHub {
    owner = "errata-ai";
    repo = "proselint";
    rev = "acedc7cb5400c65201ff06382ff0ce064bc338cb";
    sha256 = "sha256-faeWr1bRhnKsycJY89WqnRv8qIowUmz3EQvDyjtl63w=";
  };
};

home.packages = [

pkgs.libreoffice-fresh
pkgs.okular
pkgs.thunderbird
pkgs.mattermost-desktop
pkgs.element-desktop
pkgs.zoom-us
pkgs.discord

pkgs.spotify
pkgs.jellyfin-media-player

pkgs.playerctl
pkgs.pamixer
pkgs.pavucontrol

pkgs.mullvad

pkgs.devour

# screenshots
pkgs.libsForQt5.spectacle
# qt-based pin entry
pkgs.pinentry_qt

# spellcheckers
pkgs.hunspell
pkgs.hunspellDicts.de_DE
pkgs.hunspellDicts.en_US
pkgs.vale

(let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-small dvisvgm dvipng # for preview and export as html
      latexmk wrapfig amsmath ulem hyperref capt-of xpatch csquotes biblatex
      placeins algorithm2e ifoddpage relsize
      # for CV:
      pdfx xmpincl fontawesome5 tcolorbox environ enumitem dashrule changepage
      multirow ifmtarg paracol lato fontaxes
      # another cv document class, with a cover letter
      limecv xstring titlesec textpos;
  });
in tex) pkgs.biber pkgs.texlab

# emacs everywhere
pkgs.xorg.xwininfo
pkgs.xdotool
pkgs.xclip
# nix formatter
pkgs.nixfmt
# shell formatting / linting
pkgs.shfmt
pkgs.shellcheck

pkgs.feh
pkgs.rofi

];

}
