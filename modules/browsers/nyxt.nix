{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nyxt;
in {
  options.modules.nyxt = {enable = mkEnableOption "nyxt";};
  config =
    mkIf cfg.enable {
      home.packages = with pkgs; [nyxt];
    };
}
