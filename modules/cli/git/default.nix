{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.git;
in {
  options.modules.cli.git = {enable = mkEnableOption "git";};
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "rxf4e1";
      userEmail = "rxf4e1@pm.me";
      extraConfig = {
        init = {defaultBranch = "main";};
        core = {
          # excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
      };
    };

    programs.lazygit.enable = true;
  };
}
