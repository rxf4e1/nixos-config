{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.foot;
in {
  options.modules.foot = {enable = mkEnableOption "foot";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.foot];
    # programs.foot = {
    #   enable = true;
    #   settings = {
    #     main = {
    #       font = "Fira-Code:size=12";
    #       dpi-aware = "auto";
    #       # pad = "0x0";
    #     };
    #     colors = {
    #       alpha = "0.9";
    #       foreground = "ffffff";
    #       background = "000000";
    #       ## Normal/regular colors (color palette 0-7)
    #       regular0 = "000000"; # black
    #       regular1 = "ff8059";
    #       regular2 = "44bc44";
    #       regular3 = "d0bc00";
    #       regular4 = "2fafff";
    #       regular5 = "feacd0";
    #       regular6 = "00d3d0";
    #       regular7 = "bfbfbf";

    #       bright0 = "595959"; # bright black
    #       bright1 = "ef8b50"; # bright red
    #       bright2 = "70b900"; # bright green
    #       bright3 = "c0c530"; # bright yellow
    #       bright4 = "79a8ff";
    #       bright5 = "b6a0ff"; # bright magenta
    #       bright6 = "6ae4b9"; # bright cyan
    #       bright7 = "ffffff"; # bright white
    #     };
    #   };
    # };
  };
}
