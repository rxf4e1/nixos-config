{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  machine_id = "aspire-a315";
  cfg = config.modules.terminal.shell.bash;
in {
  options.modules.terminal.shell.bash = {enable = mkEnableOption "bash";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bashSnippets
      nix-bash-completions
      nodePackages.bash-language-server
      shfmt
    ];
    home.sessionPath = [
      "/home/rxf4e1/.local/bin"
      "/home/rxf4e1/.cargo/bin"
      "/home/rxf4e1/.cache/.bun/bin"
    ];

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historyFile = "\${HOME}/.bash_history";
      historyFileSize = 5000;
      historyIgnore = ["cd" "ls" "ls -la" "la" "ll" "exit"];
      historySize = 5000;
      historyControl = ["erasedups" "ignoredups" "ignorespace"];

      sessionVariables = {
        VISUAL = "\${EDITOR}";
        PAGER = "less";
        LC_COLLATE = "C";
      };

      shellAliases = {
        cat = "bat";
        cd = "gd";
        less = "bat --paging=always";
        sudo = "doas";
        pandoc = "pandoc --pdf-engine tectonic";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        du = "du -hs";
        df = "df -h";
        md = "mkdir -pv";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -Iv";

        v = "nano -v";

        rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#${machine_id}'";
        rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#${machine_id}'";
        gc = "nix-collect-garbage --delete-old";
        gcd = "doas nix-collect-garbage --delete-old";
      };
      shellOptions = ["histappend" "checkwinsize" "extglob" "globstar" "checkjobs"];

      initExtra = ''
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
      '';
      bashrcExtra = ''
        export PS1="\e[0;32m\w\e[m\n% "
        source ~/.bashrc.local
        # source ~/.LESS_TERMCAP
      '';
    };

    programs.readline = {
      enable = true;
      includeSystemConfig = true;
      extraConfig = ''
        # Prettify
        set colored-stats on
        set colored-completion-prefix on
        set visible-stats on
        set mark-symlinked-directories on

        # Completion Settings
        set show-all-if-ambiguous on
        set completion-ignore-case on
        set menu-complete-display-prefix on
      '';
    };

    home.file.".bashrc.local".source = ./cfg/bashrc.local;
  };
}
