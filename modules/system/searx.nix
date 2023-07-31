{
  pkgs,
  lib,
  ...
}: {
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      use_default_settings = true;
      server = {
        port = "8888";
        bind_address = "0.0.0.0";
        # base_url = "http://optin.privacy";
        secret_key = "7x7maw1e";
        http_protocol_version = "1.1"; # 1.0 or 1.1 only
        method = "POST";
        default_http_headers = {
          X-Content-Type-Options = "nosniff";
          X-XSS-Protection = "1; mode=block";
          X-Download-Options = "noopen";
          X-Robots-Tag = "noindex, nofollow";
          Referrer-Policy = "no-referrer";
        };
      };
      search = {
        safe_search = 0;
        autocomplete = "brave";
        prefer_configured_language = false;
      };
      ui = {
        autofocus = true;
        archive_today = false;
        static_path = "";
        templates_path = "";
        # default_theme = "oscar";
        default_locale = "";
        results_on_new_tab = true;
        # categories_order = {};
      };
      engines = lib.singleton
        {
          name = "brave";
          shortcut = "br";
          base_url = "https://search.brave.com/";
          search_string = "search?q=%s";
        };
    };
  };
}
