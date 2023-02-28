{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.lsd;
in {
  options.modules.cli.lsd = {enable = mkEnableOption "LSD";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.lsd];
    programs.bash.shellAliases = {
      ls = "lsd";
      la = "ls --long --all --no-symlink";
      lt = "ls --tree --no-symlink";
    };
  };
}
