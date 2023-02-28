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
        createDirectories = true;
        documents = "$HOME/Documents/";
        download = "$HOME/Downloads/";
        videos = "$HOME/Videos/";
        music = "$HOME/Music/";
        pictures = "$HOME/Pictures/";
        desktop = "$HOME/Desktop/";
        publicShare = "$HOME/Public/";
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
