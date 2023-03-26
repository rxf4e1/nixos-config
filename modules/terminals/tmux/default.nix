{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.emu.tmux;
in {
  options.modules.terminal.emu.tmux = {enable = mkEnableOption "tmux";};

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-s";
      keyMode = "emacs";
      baseIndex = 1;
      aggressiveResize = true;
      clock24 = true;
      disableConfirmationPrompt = false;
      escapeTime = 5;
      historyLimit = 1000;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-battery false
            set -g @dracula-show-powerline true
            set -g @dracula-refresh-rate 10
          '';
        }
      ];
      extraConfig = ''
        set -g status off
        set -g visual-activity on
        set -g mouse on
        set -g default-terminal 'tmux-256color'
        # set-option -sa terminal-features ',xterm-kitty:RGB'
        set-option -g focus-events on

        # source-file ~/.config/tmux/themes/tomorrow_night_bright.tmux
      '';
    };
  };
}
