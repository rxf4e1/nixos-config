# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."enc" = {
    device = "/dev/disk/by-uuid/5d2490c8-9512-41d1-a385-0106d6b4413e";
    preLVM = true;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c4f40797-3429-41ca-b18d-5270dc73bd61";
      fsType = "btrfs";
      options = [ "subvol=@" "compress-force=zstd" "noatime" "ssd"];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7E73-63EF";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c4f40797-3429-41ca-b18d-5270dc73bd61";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress-force=zstd" "noatime" "ssd"];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/c4f40797-3429-41ca-b18d-5270dc73bd61";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress-force=zstd" "noatime" "ssd"];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/c4f40797-3429-41ca-b18d-5270dc73bd61";
      fsType = "btrfs";
      options = [ "subvol=@var" "compress-force=zstd" "noatime" "ssd"];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/45a5588d-ae4a-4a17-ae26-d5df5f94fd40"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
