{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.firefox;
in {
  options.modules.firefox = {
    enable = mkEnableOption "firefox";
  };
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.firefox
      # pkgs.mullvad-browser
    ];
    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          enableTridactylNative = true;
        };
      }
    };
  };
}
