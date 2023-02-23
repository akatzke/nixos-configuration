{ osConfig, config, pkgs, ... }:
let
  user = "yusu";
  name = "Jonas Opitz";
in {

home.stateVersion = "22.11";

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
  set EDITOR vim
'';

services.gpg-agent.pinentryFlavor = "curses";

home.packages = [

pkgs.pinentry-curses
pkgs.blocky

];

}
