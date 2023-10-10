# NixOS + Encryption + BtrFS

## USE SGDISK AS PARTITIONER
### How to use
  - $ sgdisk [options] \<device\>

### My Use Case
  1. Delete all existing partitions
```sh
  sgdisk --zap-all /dev/sdX
```
  
  2. Set disk variable
```sh
  disk=/dev/disk/by-id/ata-...
```

  3. Create partitions
    Arguments used:
    - (-n), --new=partnum:start:end
    - (-t), --typecode=partnum:{hexcode|GUID}
    - (-c), --change-name=partnum:name
    ex.: $ sgdisk -n0:0:+1(K|M|G) -t0:EF00 -c0:PARTNAME $disk

    Typecodes:
    - EF00 - EFI Partition
    - 8200 - Linux Swap
    - 8300 - Linux Partition

    then:
```sh
  sgdisk -a1 -n0:1M:+512M -t0:EF00 -c 0:BOOT $disk
  sgdisk -n2:0:+16G -t2:8200 -c 2:SWAP $disk
  sgdisk -n3:0:800 -t3:8300 -c 3:ROOT $disk
```

## ENCRYPT ROOT
  - $ cryptsetup -verify-passphrase -cipher serpent-cbc-essiv:sha256 -key-size 256 luksFormat $disk-part3
  - $ cryptsetup open $disk-part3 enc

## FORMATTING
### Setting partitions variables
  - $ boot=$disk-part1
  - $ swap=$disk-part2
  - $ root=/dev/mapper/enc

### Mkfs
  - $ mkfs.vfat -n BOOTFS -F32 $boot
  - $ mkswap -L SWAPFS $swap && swapon $swap
  - $ mkfs.btrfs -L ROOTFS $root

## MOUNTING SYSTEM
### Create Subvolumes
  - $ mount $root /mnt    # wondering how to mount in tmpfs.
  - $ btrfs subvolume create /mnt/nix
  - $ btrfs subvolume create /mnt/home
  - $ btrfs subvolume create /mnt/log
  - $ umount /mnt
### Mount Partitions
  - $ mount $root /mnt
  - $ mkdir -pv /mnt/{boot,nix,home,var/log}
  - $ mount $boot /mnt/boot
  - $ mount -o subvol=nix,compress-force=zstd,noatime $root /mnt/nix
  - $ mount -o subvol=log,compress-force=zstd,noatime $root /mnt/var/log
  - $ mount -o subvol=home,compress-force=zstd $root /mnt/home
