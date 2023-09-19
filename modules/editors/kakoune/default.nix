{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.kakoune;
in {
  options.modules.editor.kakoune = {enable = mkEnableOption "Kakoune";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # kakoune-unwrapped
      kakoune-cr
      kak-lsp
    ];

    programs.kakoune = {
      enable = true;
      package = pkgs.kakoune-unwrapped;
      plugins = with pkgs; [
        kakounePlugins.auto-pairs-kak
        kakounePlugins.fzf-kak
        kakounePlugins.smarttab-kak
        kakounePlugins.zig-kak
      ];
      config = {
        alignWithTabs = true;
        autoComplete = ["insert" "prompt"];
        autoInfo = ["command" "onkey" "normal"];
        autoReload = "ask";
        incrementalSearch = true;
        indentWidth = 2;
        scrollOff = {
          columns = 3;
          lines = 5;
        };
        showMatching = true;
        showWhitespace = {
          enable = false;
          lineFeed = "¬";
          nonBreakingSpace = "⍽";
          space = "·";
          tab = "→";
          tabStop = " ";
        };
        tabStop = 2;
        ui = {
          enableMouse = false;
          assistant = "none";
          statusLine = "bottom";
          useBuiltinKeyParser = false;
        };
        wrapLines = {
          enable = true;
          indent = true;
          marker = true;
          # maxWidth = 100;
          word = true;
        };
      };
      extraConfig = ''
      # ────────────────────────────────────────────────────
      set global startup_info_version 999999999
      # ────────────────────────────────────────────────────
      set-option global grepcmd 'rg --column'
      set-option eolformat lf
      # ────────────────────────────────────────────────────
      evaluate-commands %sh{
        # We're assuming the default bundle_path here...
        plugins="$kak_config/bundle"
        mkdir -p "$plugins"
        [ ! -e "$plugins/kak-bundle" ] && \
          git clone -q https://github.com/jdugan6240/kak-bundle "$plugins/kak-bundle"
        printf "%s\n" "source '$plugins/kak-bundle/rc/kak-bundle.kak'"
      }
      bundle-noload kak-bundle https://github.com/jdugan6240/kak-bundle
      # ────────────────────────────────────────────────────
      try %{
        source "%val{kak_config}/kakrc.local"
        enable-auto-pairs
      }
      # ────────────────────────────────────────────────────
      evaluate-commands %sh{kcr init kakoune}
      # ────────────────────────────────────────────────────
      evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
      hook global WinSetOption filetype=(sh|nix|rust|zig|c|javascript|typescript) %{
        lsp-enable-window
      }
      # ────────────────────────────────────────────────────
      '';
    };

    home.sessionVariables.EDITOR = "kcr edit";
    home.shellAliases = {
      k = "kcr edit";
      kl = "kcr list";
      ka = "kcr attach";
    };
  };
}
