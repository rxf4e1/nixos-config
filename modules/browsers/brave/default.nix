{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.brave;
in {
  options.modules.brave = {
    enable = mkEnableOption "brave";
  };
  config = mkIf cfg.enable {
    home.packages = [
      # pkgs.brave
      pkgs.vivaldi
      pkgs.vivaldi-ffmpeg-codecs # support for proprietary codecs
    ];
    # home.file.".config/brave-flags.conf".source = ./brave-flags.conf;
  };
}
