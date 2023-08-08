{ pkgs, ... }:
{
  hardware.opengl =
    let
      pkgsMesaClover = import
        (pkgs.fetchFromGitHub {
          owner = "sbruder";
          repo = "nixpkgs";
          rev = "41d33334ec2d07da8f5bd0f3749949241c42266b";
          sha256 = "sha256-sA/kwZ8kXuRC/sLjja2ISpyTnlEwZjifyYeiz9hFWRE=";
        })
        { inherit (pkgs) system; };
    in
    {
      package = pkgsMesaClover.mesa-opencl.drivers;
      extraPackages = [
        pkgsMesaClover.mesa-opencl
      ];
    };
}
