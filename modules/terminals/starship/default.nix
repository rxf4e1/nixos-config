{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.prompt.starship;
in {
  options.modules.terminal.prompt.starship = {enable = mkEnableOption "Starship Prompt";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.starship];
  };
}
