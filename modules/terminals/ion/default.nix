{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.shell.ion;
in {
  options.modules.shell.ion = {enable = mkEnableOption "ion";};
  config =
    mkIf cfg.enable {
    };
}
