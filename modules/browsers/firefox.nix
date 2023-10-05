{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  browser = "firefox";
  cfg = config.modules.firefox;
in {
  options.modules.firefox = {
    enable = mkEnableOption "firefox";
  };
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.${browser}
      # pkgs.librewolf
      # pkgs.mullvad-browser
    ];

    home.sessionVariables = {
      BROWSER = "${browser}";
    };
    
    programs.firefox = {
      enable = false;
      package = pkgs.firefox;
    };

    programs.librewolf = {
      enable = false;
      package = pkgs.librewolf;
      settings = {
        # Letterboxing helps limit fingerprinting by only expanding or
        # shrinking the inner window size in fixed increments, letting you
        # blend in with a larger number of users.
        "privacy.resistFingerprinting.letterboxing" = true;

        # This override allows you to control when a cross-origin refer will
        # be sent, allowing it exclusively when the host matches.
        "network.http.referer.XOriginPolicy" = 2;

        # If need to enable WebGL: in that case consider Canvas Blocker add-on.
        # Alternatively, I could use pref()
        # This way, I could still turn on WebGL as needed, but, even if I
        # forgot to turn it off again, it would be disabled next time I launch
        # the browser.
        "webgl.disabled" = true;

        # Disable WebRTC
        "media.peerconnection.enabled" = false;

        # To enable Firefox Sync
        # defaultPref("identity.fxaccounts.enabled", true);

        # By default, LibreWolf deletes your browsing and download history on
        # shutdown.
        # defaultPref("privacy.clearOnShutdown.history", false);
        # defaultPref("privacy.clearOnShutdown.downloads", false);

        # If you are experiencing OCSP issues this will change mode to soft-fail.
        # defaultPref("security.OCSP.require", false);
      };
    };
  };
}
