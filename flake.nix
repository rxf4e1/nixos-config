{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # emacs-overlay.url = "github:nix-community/emacs-overlay";

    hyprland.url = "github:hyprwm/Hyprland";

    newmpkg.url = "github:jbuchermn/newm";
    newmpkg.inputs.nixpkgs.follows = "nixpkgs";

    pywm-fullscreenpkg.url = "github:jbuchermn/pywm-fullscreen";
    pywm-fullscreenpkg.inputs.nixpkgs.follows = "nixpkgs";

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    home-manager,
    nixpkgs,
    newpkg,
    pywm-fullscreenpkg,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;

    # This let us reuse the code to "create" a system
    # Credits go to sioodmy on this one!
    # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
    mkSystem = pkgs: system: hostname:
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
          {networking.hostName = hostname;}
          # General configuration (users, networking, sound, etc)
          ./modules/system/configuration.nix
          # Hardware config (bootloader, kernel modules, filesystems, etc)
          (./. + "/hosts/${hostname}/hardware-configuration.nix")
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs;};
              # H-M config (configures programs like brave, bash, etc)
              users.rxf4e1 = ./. + "/hosts/${hostname}/user.nix";
            };
            nixpkgs.overlays = [
              (self: super: {
                newm = newmpkg.packages.${system}.newm;
                pywm-fullscreen = pywm-fullscreenpkg.packages.${system}.pywm-fullscreen;
              })
              # inputs.emacs-overlay.overlay
              # nur.overlay
              # (import ./overlays)
            ];
          }
          inputs.hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
        specialArgs = {inherit inputs;};
      };
  in {
    nixosConfigurations = {
      # Now, defining a new system can be done in one line
      #                                     Architecture   Hostname
      aspire-a315 = mkSystem inputs.nixpkgs "x86_64-linux" "aspire-a315";
      # home-server = mkSystem inputs.nixpkgs "x86_64-linux" "home-server";
    };
  };
}
