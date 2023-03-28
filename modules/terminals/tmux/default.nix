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
      prefix = "C-a";
      keyMode = "vi";
      baseIndex = 1;
      aggressiveResize = true;
      clock24 = true;
      disableConfirmationPrompt = false;
      escapeTime = 0;
      historyLimit = 1000;
      extraConfig = ''
        set -g status off
        set -g visual-activity on
        set -g mouse on
        set -g default-terminal 'tmux-256color'
        # set-option -sa terminal-features ',xterm-kitty:RGB'
        set-option -g focus-events on

        bind r source-file ~/.config/tmux/tmux.conf

        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy -po'

        bind -r ^ last-window
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R
      '';
    };
  };
}
