{
  config,
  lib,
  pkgs,
  ...
}: let
  machine_id = "${config.networking.hostName}";

  sysad = pkgs.writeShellScriptBin "sysad" ''

    dir=$HOME/.dotfiles/nixos-config

    cd $dir

    update_() {
      doas nix flake update
    }

    switch_() {
      doas nixos-rebuild switch --flake ."#${machine_id}";
    }

    boot_() {
      read -p "Collect Garbage? [y/N]: " opt

      if [[ $opt == "y" || $opt == "Y" ]]; then
        doas nix-collect-garbage --delete-old;
        doas nixos-rebuild boot --flake ."#${machine_id}";
      elif [[ $opt == "n" || $opt == "N" || -z $opt ]]; then
        doas nixos-rebuild boot --flake ."#${machine_id}";
      else
        echo "Wrong option!";
        boot_
      fi

      echo "DONE!";
      exit
    }

    build_() {
      doas nixos-rebuild build --flake ."#${machine_id}";
    }

    help_() {
        echo "Usage: sysad [u\s\b\B\h]"
        echo
        echo "u - update"
        echo "s - switch"
        echo "b - boot"
        echo "B - build"
        echo "h - this help"
        echo
    }

    case $@ in
      "u")
          update_
          ;;
      "s")
          switch_
          ;;
      "b")
          boot_
          ;;
      "B")
          build_
          ;;
      "h")
          help_
          ;;
      *)
          echo "Invalid argument!"
          exit
          ;;
    esac
  '';
in {
  environment.systemPackages = with pkgs; [sysad];
}
