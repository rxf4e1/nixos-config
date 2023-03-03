{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.fzf;
in {
  options.modules.cli.fzf = {enable = mkEnableOption "FzF";};
  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 30%"];
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = ["--preview 'lsd --tree --color=always -L 4 {}'"];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = ["--preview 'head -n 100 {}'"];
    };
  };
}