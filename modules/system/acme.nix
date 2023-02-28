{
  config,
  pkgs,
  ...
}: let
  myEmail = "rxf4el@duck.com";
in {
  security.acme = {
    acceptTerms = true;
    defaults.email = myEmail;
  };
}
