{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.bash;
in {
  options.modules.bash = {enable = mkEnableOption "bash";};

  config = mkIf cfg.enable {
    home.packages = [pkgs.bashSnippets pkgs.nix-bash-completions];

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historyFile = "$HOME/.bash_history";
      historyFileSize = 5000;
      historyIgnore = ["cd" "ls" "ls -la" "la" "ll" "exit"];
      historySize = 5000;
      historyControl = ["erasedups" "ignoredups" "ignorespace"];

      sessionVariables = {
        BROWSER = "brave";
        EDITOR = "kcr edit";
        VISUAL = "$EDITOR";
        PAGER = "less";
        LC_COLLATE = "C";
      };

      shellAliases = {
        cat = "bat";
        less = "bat --paging=always";
        ls = "lsd";
        la = "ls --long --all --no-symlink";
        lt = "ls --tree --no-symlink";
        sudo = "doas";
        pandoc = "pandoc --pdf-engine tectonic";
        d = "br";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        md = "mkdir -pv";
        rm = "rm -rf";
        # brave = "GDK_BACKEND='wayland' brave --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
        # x = "startx";
      };
      shellOptions = ["histappend" "checkwinsize" "extglob" "globstar" "checkjobs"];

      initExtra = ''
        export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
      '';
      bashrcExtra = ''
        export PS1="\e[0;32m\w\e[m\n% "
      '';
      # logoutExtra = '''';
      # profileExtra = '''';
    };

    # Edit ~/.inputrc
    programs.readline = {
      enable = true;
      includeSystemConfig = true;
      # variables = {};
      # bindings = {
      #   # "\\C-b" = ''cd ..\n'';
      # };
      extraConfig = ''
        # Prettify
        set colored-stats on
        set colored-completion-prefix on

        # Completion Settings
        set show-all-if-ambiguous on
        set completion-ignore-case on

      '';
    };
  };
}
