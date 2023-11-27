{
  # pkgs,
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
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      defaultKeymap = "emacs";
      enableVteIntegration = true;
      autocd = false;
      syntaxHighlighting.enable = false;
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
        BROWSER = "librewolf";
        VISUAL = "$EDITOR";
        PAGER = "less";
        LC_COLLATE = "C";
      };
      initExtra = ''
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
        path+=("$HOME/.local/bin" "$HOME/.luarocks/bin" "$HOME/.cargo/bin")
      '';
    };
  };
}
