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
    ./secret
    ./packages
  ];
}
