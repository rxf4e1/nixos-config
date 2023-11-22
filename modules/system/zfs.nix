{pkgs, ...}: {
  boot = {
    kernelParams = [ "zfs.zfs_arc_max=6442450944" ]; # 6Gb -> Bytes
    supportedFilesystems = ["zfs"];
  };
  networking.hostId = "d34db33f";
  services = {
    zfs.autoScrub.enable = true;
    zfs.trim.enable = true;
  };
}
