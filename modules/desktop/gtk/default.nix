{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = {enable = mkEnableOption "Gtk";};
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "Nordzy-cursor";
        package = pkgs.nordzy-cursor-theme;
        size = 16;
      };
      font = {
        name = "Monospace";
        size = 10;
      };
      iconTheme = {name = "Sweet-Rainbow";};
      theme = {
        name = "Sweet-Dark";
        package = pkgs.sweet;
      };
    };
  };
}
