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
        desktop = "$HOME/desktop";
        documents = "$HOME/documents";
        download = "$HOME/downloads";
        pictures = "$HOME/pictures";
        publicShare = "$HOME/public";
        templates = "$HOME/templates";
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
