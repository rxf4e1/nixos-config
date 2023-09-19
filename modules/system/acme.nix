{
  ...
}: let

	myDomain = "optin.org";
	acmeChallengesDir = "/var/lib/acme/acme-challenge";

in {
  security.acme = {
    acceptTerms = true;
    certs = {
      "${myDomain}" = {
        email = "0xf4e1@tuta.io";
        webroot = acmeChallengesDir;
      };
    };
  };

  services.nginx = {
    enable = true;
    # Use recommended settings
    # recommendedGzipSettings = true;
    # recommendedOptimisation = true;
    # recommendedProxySettings = true;
    # recommendedTlsSettings = true;
    virtualHosts."${myDomain}" = {
      addSSL = true;
      enableACME = true;
      root = "/var/www/${myDomain}";
    };
    # logError = "stderr debug";
  };
}
