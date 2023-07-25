{
  ...
}: {
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = "8080";
        bind_address = "0.0.0.0";
        base_url = "https://optin.privacy";
        secret_key = "7x7maw1e";
      };
      # engines = lib.singleton
      #   {
      #     name = "wolframalpha";
      #     shortcut = "wa";
      #   };
    };
  };
}
