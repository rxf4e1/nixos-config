{...}: {
  boot = {
    kernelParams = [ "zfs.zfs_arc_max=6442450944" ]; # Arc Max: 2GiB -> Bytes  
    # kernelParams = [ "zfs.zfs_arc_max=2147483648" ]; # Arc Max: 2GiB -> Bytes  
    supportedFilesystems = ["zfs"];
  };
  networking.hostId = "d34db33f";
  services = {
    zfs.autoScrub.enable = true;
    zfs.trim.enable = true;
  };
}
