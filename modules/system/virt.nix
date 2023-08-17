{
  pkgs,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        runAsRoot = false;
      };
    };
    waydroid.enable = false;
  };
  environment.systemPackages = [
    # virt-manager
    # libguestfs
  ];

  users.users.rxf4e1.extraGroups = ["libvirtd" "kvm"];
}
