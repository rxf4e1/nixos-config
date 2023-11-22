{lib,pkgs, ...}: {
  # Remove unecessary preinstalled packages
  environment.defaultPackages = [];
  
  imports = [ ./zfs.nix ];

  environment = {
    # Generic Packages (others are managed in `packages.nix`)
    systemPackages = with pkgs; [
      git
      curl
      wget
      cachix
      acpi
      lm_sensors
      tlp
      dnsutils
      openssl
      pciutils
      vulkan-headers
      vulkan-loader
      vulkan-tools
      gnome.adwaita-icon-theme
      pulseaudio
    ];
    # Set environment variables
    variables = {
      NIXOS_CONFIG = "$HOME/.dotfiles/nixos-config";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      # DISABLE_QT5_COMPAT = "0";
      NIXOS_OZONE_WL = "1";

      # Force AMDVLK - (opensource)
      # AMD_VULKAN_ICD = "AMDVLK";
      # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";

      # Force RADV - (proprietary)
      AMD_VULKAN_ICD = "RADV";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

      # FIX:
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/AMD";
    };
  };

  # Install Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
      terminus-nerdfont
      inconsolata
      liberation_ttf
      jetbrains-mono
      joypixels
    ];
    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = ["joypixels"];
        monospace = ["Terminess Nerd Font Mono"];
      };
    };
  };

  # Wayland stuff: XDG integration, allow sway to use brillo
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        # pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  # Nix settings, autocleanup and flakes
  nixpkgs.config = {
    allowUnfree = true;
    joypixels.acceptLicense = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      builders-use-substitutes = true;
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      allowed-users = ["rxf4e1"];
      trusted-users = ["root" "rxf4e1"];
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  # Boot settings: clean /tmp/, latest kernel and bootloader
  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_background_ratio" = 1;
    };
    readOnlyNixStore = true;
    supportedFilesystems = ["ntfs"];
    tmp.useTmpfs = true;
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      systemd-boot.consoleMode = "auto";
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    plymouth = {
      enable = false;
      theme = "breeze";
    };
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Set up users
  # if warning GID not change:
  # as root -> groupmod -g <NEW-GID> <GROUP-NAME>
  users = {
    users.rxf4e1 = {
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 1000;
      group = "users";
      extraGroups = [
        "adbusers"
        "input"
        "wheel"
        "video"
        "audio"
        "kvm"
        "openrazr"
      ];
    };
  };

  # Set up networking and secure it
  networking = {
    # Quad-9 DNS
    nameservers = ["9.9.9.9" "149.112.112.112"];
    networkmanager = {
      enable = false;
      wifi = {
        backend = "wpa_supplicant"; # or iwd
        # macAddress = "random";
      };
      # dns = "none";
    };
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
          # AddressRandomization = "network";
        };
        # Settings = { AlwaysRandomizeAddress = true; };
        Network = {
          NameResolvingService = "systemd";
        };
      };
    };

    firewall = {
      enable = false;
         allowedTCPPorts = [ 80 443 ];
         allowedUDPPorts = [ 80 443 ];
         allowPing = true;
    };
  };

  # Security
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["rxf4e1"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    # Extra security
    protectKernelImage = true;
  };

  programs.adb.enable = true;
  programs.dconf.enable = true;
  programs.light.enable = true;
  programs.zsh.enable = true;

  # DBUS
  services = {
    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };
    # fstrim.enable = true;
    fwupd.enable = true;
    udev = {enable = true;};
    journald.console = "/dev/tty12";
    upower.enable = true; # Battery info & stuff
    xserver = {
      desktopManager.xterm.enable = false;
      videoDrivers = lib.mkDefault ["amdgpu"];
    };
  };

  systemd.coredump.enable = true;

  # Sound
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Set up hardware stuff: bluetooth opengl etc
  hardware = {
    bluetooth.enable = false; # disabled until need it
    openrazer.enable = true; # mice drivers
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.libdrm
        pkgs.libva
        # pkgs.rocm-opencl-icd
        # pkgs.rocm-opencl-runtime
      ];
    };
  };

  # Do not touch this
  system.stateVersion = "20.09";
}
