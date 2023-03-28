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
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 30%"];
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = ["--preview 'lsd --tree --color=always -L 4 {}'"];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = ["--preview 'head -n 100 {}'"];
    };
    home.sessionVariables = {
      FZF_COMPLETION_TRIGGER = "**";
      FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1 \
         --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
         --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
         --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
         --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4";
    };
  };
}
