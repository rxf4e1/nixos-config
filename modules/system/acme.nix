{
  pkgs,
  ...
}:

let

	myDomain = "optin.org";
	# acmeChallengesDir = "/var/lib/acme/acme-challenge";

in {
  # security.acme = {
  #   acceptTerms = true;
  #   certs = {
  #     "${myDomain}" = {
  #       email = "0xf4e1@tuta.io";
  #       webroot = acmeChallengesDir;
  #     };
  #   };
  # };

  services.nginx = {
    enable = true;
    # Use recommended settings
    # recommendedGzipSettings = true;
    # recommendedOptimisation = true;
    # recommendedProxySettings = true;
    # recommendedTlsSettings = true;
    virtualHosts."${myDomain}" = {
      # addSSL = true;
      # enableACME = true;
      listen = [
        {
          # 0x101.duckdns.org
          addr = "[2804:431:c7c9:c323:d652:c94:fbb0:e7b6]";
          port = 10123;
        }
      ];
      root = "/srv/www/optin";
    };
    # defaultListenAddresses = ["10.0.0.10" "[2804:431:c7c8:a8de:a663:a1ff:fe25:aa98]"];
    # defaultHTTPListenPort = 10123;
  };

}
