# This module defines a small NixOS installation CD. It does not
# contain any graphical stuff.
{ config, pkgs, lib, ... }:
{
  imports = [
    # Currently fails on NixOS 23.05 to build due to ZFS incompatibility with bcachefs
    #<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix>
  ];
  boot.supportedFilesystems = [ "bcachefs" ];
  # kernelPackages already defined in installation-cd-minimal-new-kernel-no-zfs.nix
  boot.kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_testing_bcachefs;
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  environment.systemPackages = with pkgs; [ keyutils tmux ];
}
