{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.gpg;
in {
  options.modules.cli.gpg = {enable = mkEnableOption "gpg";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.gnupg];
    programs.gpg = {
      enable = true;
    };
    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableSshSupport = true;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyGWhb0MNCq5K16DfBWQn0chx4jEDSnV9fVvR+Igmzi rxf4e1@pm.me"
      ];
      grabKeyboardAndMouse = true;
      pinentryFlavor = "curses";
    };
    home.sessionVariables = {
      SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
    };
    # programs.bash.initExtra = ''
    #   export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    #   gpgconf --launch gpg-agent
    # '';
  };
}
