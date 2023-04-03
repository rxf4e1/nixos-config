{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.broot;
in {
  options.modules.cli.broot = {enable = mkEnableOption "Broot";};
  config = mkIf cfg.enable {
    # home.packages = [pkgs.broot];
    programs.broot = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        quit_on_last_cancel = true;
        show_selection_mark = true;
        default_flags = "gIh";
        true_colors = true;
        capture_mouse = false;
        verbs = [
          {
            invocation = "ok";
            key = "enter";
            leave_broot = true;
            external = "$EDITOR +{line} {file}";
            apply_to = "file";
          }
        ];
        special_paths = {
          "**/.direnv" = "no-enter";
          "**/.git" = "no-enter";
        };
      };
    };
    home.shellAliases = {
      d = "br";
    };
  };
}
