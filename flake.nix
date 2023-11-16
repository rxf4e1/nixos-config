{
  description = "NixOS flake configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    home-manager,
      nixpkgs,
      emacs-overlay,
    # nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    # lib = nixpkgs.lib;

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
              (import inputs.emacs-overlay)
              # nur.overlay
              # (import ./overlays)
            ];
          }
        ];
        specialArgs = {inherit inputs;};
      };
  in {
    nixosConfigurations = {
      # Now, defining a new system can be done in one line
      #                                     Architecture   Hostname
      aspire-a315 = mkSystem inputs.nixpkgs system "aspire-a315";
      # home-server = mkSystem inputs.nixpkgs "x86_64-linux" "home-server";
    };
  };
}
