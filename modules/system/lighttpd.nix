{pkgs, ...}: let
  myDomain = "optin.org";
  acmeChallengeDir = "/var/lib/acme/acme-challenge/";
in {
  security.acme = {
    acceptTerms = true;
    certs."${myDomain}" = {
      email = "0xf4e1@tuta.io";
      webroot = acmeChallengeDir;
      postRun = ''doas systemctl restart lighttpd'';
    };
  };

  services.lighttpd = {
    # https://github.com/bjornfor/nixos-config/blob/master/profiles/webserver.nix
    enable = true;
    package = pkgs.lighttpd;
    port = 8080;
    document-root = "/srv/www";
    mod_status = true;
    mod_userdir = false;
    enableModules = [
      "mod_alias"
      "mod_proxy"
      "mod_access"
      "mod_fastcgi"
      "mod_redirect"
      "mod_openssl"
      "mod_auth"
    ];
  };
}
