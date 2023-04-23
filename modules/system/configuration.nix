{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Remove unecessary preinstalled packages
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;

  imports = [
    # ./acme.nix
    # ./virt.nix
  ];

  environment = {
    # Generic Packages (others are managed in `packages.nix`)
    systemPackages = with pkgs; [
      git
      curl
      wget
      acpi
      glib
      gnumake
      lm_sensors
      tlp
      dnsutils
      pciutils
      vulkan-headers
      vulkan-loader
      vulkan-tools
      gnome.adwaita-icon-theme
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
      AMD_VULKAN_ICD = "AMDVLK";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";

      # Force RADV - (proprietary)
      # AMD_VULKAN_ICD = "RADV";
      # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      # FIX:
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/amd";
    };
  };

  # Install Fonts
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      # (nerdfonts.override {
      #   fonts = ["Inconsolata"];
      # })
      fira-code
      fira-code-symbols
      liberation_ttf
      joypixels
    ];
    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = ["joypixels"];
        monospace = ["Fira Code"];
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
      substituters = [
        # "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      allowed-users = ["rxf4e1"];
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  # Boot settings: clean /tmp/, latest kernel and bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = ["btrfs" "ntfs"];

    tmp.useTmpfs = true;
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 2;
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
      # shell = pkgs.zsh;
      shell = pkgs.bash;
      uid = 1000;
      group = "users";
      extraGroups = [
        "adbusers"
        "input"
        "wheel"
        "video"
        "audio"
        # "pipewire"
        "networkmanager"
      ];
    };
  };

  # systemd.coredump.enable = true;

  # Set up networking and secure it
  networking = {
    # Quad-9 DNS
    nameservers = ["9.9.9.9" "149.112.112.112"];
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant"; # or iwd
        macAddress = "random";
      };
      # dns = "none";
    };
    # wireless.iwd = {
    #   enable = true;
    #   settings = {
    #     General.AddressRandomization = "network";
    #     Settings = {
    #       # change both to true for ipv6.
    #       AlwaysRandomizeAddress = true;
    #       EnableIPv6 = true;
    #     };
    #   };
    # };

    firewall = {
      enable = false;
      #    allowedTCPPorts = [ 80 443 ];
      #    allowedUDPPorts = [ 80 443 ];
      #    allowPing = false;
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
  # programs.zsh.enable = true;

  # DBUS
  services = {
    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };
    udev = {enable = true;};
    journald.console = "/dev/tty12";
    upower.enable = true; # Battery info & stuff
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   wireplumber.enable = true;
  #   audio.enable = true;
  #   # alsa.enable = true;
  #   # alsa.support32Bit = true;
  #   # jack.enable = true;
  #   # pulse.enable = true;
  # };

  # Set up hardware stuff: bluetooth opengl etc
  hardware = {
    bluetooth.enable = false; # disabled until need it
    openrazer.enable = true; # mice drivers
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libdrm
        libva
        amdvlk
        # rocm-opencl-icd
        # rocm-opencl-runtime
      ];
    };
  };

  # Do not touch this
  system.stateVersion = "20.09";
}
