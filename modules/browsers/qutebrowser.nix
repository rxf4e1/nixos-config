{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.qutebrowser;
in {
  options.modules.qutebrowser = {enable = mkEnableOption "qutebrowser";};
  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings.fonts.default_size = "7pt";
      searchEngines = {
        DEFAULT = "https://search.brave.com/search?q={}";
        no = "https://search.nixos.org/options?query={}";
        np = "https://search.nixos.org/packages?query={}";
        nw = "https://nixos.wiki/index.php?search={}";
        g = "https://www.google.com/search?hl=en&q={}";
        gs = "https://scholar.google.com/scholar?q={}";
        gh = "https://github.com/search?q={}";
        isbn = "https://isbnsearch.org/search?s={}";
        ncbi = "https://www.ncbi.nlm.nih.gov/nuccore/?term={}";
        od = "https://odysee.com/$/search?q={}";
        pub = "https://pubmed.ncbi.nlm.nih.gov/?term={}";
        # ud = "https://www.udemy.com/courses/search/?src={}";
        yt = "https://www.youtube.com/results?search_query={}";
      };
      enableDefaultBindings = true;
      keyBindings = {
        normal = {
          "<Ctrl-v>" = "hint links spawn --detach mpv --force-window yes {hint-url}";
        };
      };
      settings = {
        url.start_pages = ["https://search.brave.com/"];
        auto_save.session = true;
        colors.webpage.darkmode.enabled = true;
        content.blocking = {
          enabled = true;
          method = "both";
        };
        input = {
          insert_mode.auto_leave = true;
          insert_mode.auto_load = true;
        };
      };
      extraConfig = ''
        config.source("matrix-theme.py")
      '';
    };
  };
}
