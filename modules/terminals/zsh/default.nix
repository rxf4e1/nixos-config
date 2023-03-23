{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = {enable = mkEnableOption "zsh";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [zsh-fzf-tab];

    programs.zsh = {
      enable = true;
      dotDir = "\${XDG_CONFIG_HOME}/zsh";
      history = {
        path = "\${XDG_CONFIG_HOME}/zsh/zsh_history";
        expireDuplicateFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      defaultKeymap = "emacs";
      enableVteIntegration = true;
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

        rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#${machine_id}'";
        rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#${machine_id}'";
        gc = "nix-collect-garbage --delete-old";
        gcd = "doas nix-collect-garbage --delete-old";
      };
      shellGlobalAliases = {};
      sessionVariables = {
        BROWSER = "brave";
        EDITOR = "kcr edit";
        VISUAL = "$EDITOR";
        PAGER = "less";
        LC_COLLATE = "C";
      };
      initExtra = ''
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
      '';
    };
  };
}
