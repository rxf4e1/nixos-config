{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.wld.notify;
in {
  options.modules.desktop.wld.notify = {enable = mkEnableOption "notify";};
  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      actions = true;
      anchor = "bottom-right";
      borderRadius = 0;
      borderSize = 2;
      defaultTimeout = 2048;
      format = "<b>%s</b>\\n%b";
      font = "JetBrains Mono 9";
      # format = "";
      # groupBy = "";
      # height = 200;
      # width = 300;
      padding = "20";
      margin = "20";
      icons = false;
      maxIconSize = 32;
      layer = "overlay";
      backgroundColor = "#0D0208";
      borderColor = "#AFFF00";
      textColor = "#AFFF00";
      extraConfig = ''
        [urgency=high]
        background-color=#002B36
        border-color=#DC322F
      '';
    };

    home.packages = with pkgs; [
      # dunst
      # fnott
      # swaynotificationcenter
      libnotify
      inotify-tools
    ];
  };
}
