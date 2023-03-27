{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    libguestfs
  ];

  users.users.rxf4e1.extraGroups = ["libvirtd"];
}
