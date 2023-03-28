{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  machine_id = "aspire-a315";
  cfg = config.modules.terminal.shell.zsh;
in {
  options.modules.terminal.shell.zsh = {enable = mkEnableOption "zsh";};
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history = {
        path = "\${XDG_CONFIG_HOME}/.config/zsh/zsh_history";
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      defaultKeymap = "emacs";
      enableVteIntegration = true;
      autocd = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        cat = "bat";
        less = "bat --paging=always";
        sudo = "doas";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        du = "du -hs";
        df = "df -h";
        md = "mkdir -pv";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -Iv";

        v = "nvim -i NONE";
        vim = "nvim -i NONE";
        nvim = "nvim -i NONE";

        ls = "lsd";
        la = "ls --long --all --no-symlink";
        lt = "ls --tree --no-symlink";

        rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#${machine_id}'";
        rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#${machine_id}'";
        gc = "nix-collect-garbage --delete-old";
        gcd = "doas nix-collect-garbage --delete-old";
      };
      # shellGlobalAliases = {};
      sessionVariables = {
        BROWSER = "brave";
        VISUAL = "$EDITOR";
        PAGER = "less";
        LC_COLLATE = "C";
      };
      initExtra = ''
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
        path+=("$HOME/.local/bin" "$HOME/.luarocks/bin" "$HOME/.cargo/bin" "$(yarn global bin)")
      '';
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
            sha256 = "0lfl4r44ci0wflfzlzzxncrb3frnwzghll8p365ypfl0n04bkxvl";
          };
        }
        # {
        #   name = "powerlevel10k";
        #   src = pkgs.zsh-powerlevel10k;
        #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        # }
        # {
        #   name = "powerlevel10k-config";
        #   src = ./p10k-config;
        #   file = "p10k.zsh";
        # }
      ];
    };
  };
}
