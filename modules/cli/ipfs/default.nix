{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.ipfs;
in {
  options.modules.cli.ipfs = {enable = mkEnableOption "ipfs";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.kubo];
    programs.bash.initExtra = ''
      export IPFS_PATH=/persist/Ipfs
    '';
  };
}
