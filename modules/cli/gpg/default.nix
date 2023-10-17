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
      enableSshSupport = true;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODY0WfRi17oHSj2Il2rHeXQmBQD03jJI+eL8gMqVlZA dev.op0x6@slmail.me"
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
