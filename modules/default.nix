inputs @ {
  pkgs,
  config,
  ...
}: {
  home.stateVersion = "21.03";
  imports = [
    ./cli
    ./browsers
    ./desktop
    ./editors
    ./terminals
    # ./direnv
    # ./git
    ./secret
    # ./gpg
    # ./xdg
    ./packages
  ];
}
