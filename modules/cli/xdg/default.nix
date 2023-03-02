{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.xdg;
in {
  options.modules.cli.xdg = {enable = mkEnableOption "xdg";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [xdg-utils];
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = false;
        documents = "$HOME/doc/";
        download = "$HOME/dl";
        pictures = "$HOME/pic/";
      };
      # mimeApps = {
      #   enable = true;
      #   associations.added = {};
      #   associations.removed = {};
      #   defaultApplication = {};
      # };
    };
  };
}
