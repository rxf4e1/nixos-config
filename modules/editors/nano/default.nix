{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor.nano;
in {
  options.modules.editor.nano = {enable = mkEnableOption "Nano";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.nano];
    home.file.".config/nano/nanorc".source = ./nanorc;
  };
}
