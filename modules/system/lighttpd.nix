{pkgs, ...}:

# let
#   myDomain = "optin.org";
#   acmeChallengeDir = "/var/lib/acme/acme-challenge/";
# in {
#   security.acme = {
#     acceptTerms = true;
#     certs."${myDomain}" = {
#       email = "0xf4e1@tuta.io";
#       webroot = acmeChallengeDir;
#       postRun = ''doas systemctl restart lighttpd'';
#     };
#   };

{
  services.lighttpd = {
    # https://github.com/bjornfor/nixos-config/blob/master/profiles/webserver.nix
    enable = true;
    package = pkgs.lighttpd;
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
    extraConfig = ''
        server.bind = "10.0.0.13"
        server.port = "8888"
        # server.use-ipv6 = "enable"
        # $SERVER["socket"] == "[2002:c0a8:f03:1::1002]:80" {
            # server.document-root = "/srv/www"
        # }
    '';
  };
}
