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
      sshKeys = ["D10AEDC5AC7B887B3C378C142C221CB77EB8EBDF"];
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
