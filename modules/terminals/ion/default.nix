{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.shell.ion;
in {
  options.modules.terminal.shell.ion = {enable = mkEnableOption "ion";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.ion];
    # programs.ion = {
    #   enable = true;
    #   package = pkgs.ion;
    #   shellAliases = {};
    #   initExtra = '''';
    # };
  };
}
