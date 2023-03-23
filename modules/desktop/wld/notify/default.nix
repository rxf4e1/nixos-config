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
      backgroundColor = "#141a1b";
      borderColor = "#16a085";
      borderRadius = 2;
      borderSize = 1;
      defaultTimeout = 0;
      format = "<b>%s</b>\\n%b";
      font = "Termsyn 10";
      # format = "";
      # groupBy = "";
      # height = 200;
      # width = 300;
      icons = true;
      maxIconSize = 32;
      layer = "overlay";
      textColor = "#FFFFFF";
      # extraConfig = '' '';
    };

    # services.fnott = {
    #   enable = true;
    #   package = pkgs.fnott;
    #   configFile = "$XDG_CONFIG_HOME/fnott/fnott.ini";
    # };
    home.packages = with pkgs; [
      dunst
      inotify-tools
      # fnott
      # mako
    ];
  };
}
