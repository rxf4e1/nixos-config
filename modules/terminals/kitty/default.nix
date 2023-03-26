{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.emu.kitty;
in {
  options.modules.terminal.emu.kitty = {enable = mkEnableOption "kitty";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.kitty];
    # programs.kitty ={
    #   enable = true;
    # };
  };
}
