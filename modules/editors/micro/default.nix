{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.micro;
in {
  options.modules.editor.micro = {enable = mkEnableOption "micro";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.micro];
  };
}
