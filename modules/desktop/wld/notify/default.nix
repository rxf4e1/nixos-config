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
      enable = false;
      actions = true;
      anchor = "bottom-right";
      borderRadius = 10;
      borderSize = 3;
      defaultTimeout = 15000;
      format = "<b>%s</b>\\n%b";
      font = "Fira Code 9";
      # format = "";
      # groupBy = "";
      # height = 200;
      # width = 300;
      padding = "20";
      margin = "20";
      icons = true;
      maxIconSize = 32;
      layer = "overlay";
      backgroundColor = "#282a36";
      borderColor = "#282a36";
      textColor = "#44475a";
      extraConfig = ''
        [urgency=low]
        border-color=#282a36

        [urgency=normal]
        border-color=#f1fa8c

        [urgency=high]
        border-color=#ff5555
      '';
    };

    home.packages = with pkgs; [
      dunst
      # fnott
      # swaynotificationcenter
      libnotify
      inotify-tools
      # mako
    ];
  };
}
