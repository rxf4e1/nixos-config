{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.helix;
in {
  options.modules.editor.helix = {enable = mkEnableOption "helix";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.helix];
  };
}
