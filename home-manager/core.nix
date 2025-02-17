{ osConfig, config, pkgs, ... }:
let
  user = "yusu";
  name = "Jonas Opitz";
in {

home.username = "${user}";
home.homeDirectory = "/home/${user}";

xdg.configFile."scripts" = {
  source = ../scripts;
  recursive = true;
};

programs.direnv = {
  enable = true;
  nix-direnv = {
    enable = true;
  };
};

programs.fish.enable = true;

programs.fish.shellAliases = {
  # make df outputs human readable
  df = "df -h";
  # show sizes in human reabable format
  free = "free -h";
  # confirm before overriding something when copying
  cp = "cp -i";
  # make ls look nices
  ls = "exa -l --color=always --group-directories-first";
  # ledger aliases
  balance="ledger --empty -f ~/ledger/main.ledger bal -X EUR";
  budget="ledger --empty -f ~/ledger/main.ledger bal ^budget -X EUR";
  ledgerviz="nix run git+https://codeberg.org/joka/ledgerviz.git --";
  # emacs as a client, whilst swallowing the terminal
  em="devour emacsclient -c";
  # interactively cd utilizing fasd
  # cdz="cd (fasd -dl | grep -iv cache | fzf 2>/dev/tty --no-sort --tac)";
  # always ignore the given options when running autorandr
  autorandr="autorandr --skip-options x-prop-non_desktop";
};

programs.fish.functions = {
  fish_user_key_bindings = {
    body = ''
      fish_vi_key_bindings
      for mode in insert default visual
        bind -M $mode \cf forward-char
      end
    '';
  };
};

programs.fish.plugins = [
  # autopair.fish adds automatic completion of paratheses, colons, etc.
  {
    name = "autopair.fish";
    src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "autopair.fish";
      rev = "1.0.4";
      sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
    };
  }
  # fasd integration for fish
  # {
  #   name = "fasd";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "oh-my-fish";
  #     repo = "plugin-fasd";
  #     rev = "38a5b6b6011106092009549e52249c6d6f501fba";
  #     sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
  #   };
  # }
];

programs.starship = {
  enable = true;
  enableFishIntegration = true;
  settings = {
    add_newline = false;
    username = {
      style_user = "green bold";
      style_root = "red bold";
      format = "[$user]($style) ";
      disabled = false;
      show_always = true;
    };
    hostname = {
      ssh_only = false;
      format = "on [$hostname](bold yellow) ";
      trim_at = ".";
      disabled = false;
    };
    directory = {
      read_only = " 🔒";
      truncation_length = 10;
      truncate_to_repo = true;
      style = "bold italic blue";
    };
  };
};

programs.gpg = {
  enable = true;
};
services.gpg-agent = {
  enable = true;
};

programs.git = {
  enable = true;
  userName = "joopitz";
  userEmail = "jonas.opitz@live.de";
};

xsession.numlock.enable = true;

programs.nix-index = {
  enable = true;
  enableFishIntegration = true;
};

programs.zoxide = {
  enable = true;
  enableFishIntegration = true;
};

nixpkgs.config.allowUnfree = true;

home.packages = [

pkgs.exa

pkgs.fzf

pkgs.glances

pkgs.zip
pkgs.unzip

pkgs.freshfetch

pkgs.ledger

pkgs.fd
pkgs.ripgrep

];

}
