{
  description = "Development packages and systems for oezguerisbert. Inspired by 'blackglasses' at TheAltF4Stream";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, self, ... }:
    let
      systems = import ./system { inherit inputs; };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          oezguerisbert-nvim = pkgs.vimUtils.buildVimPlugin {
            name = "oezguerisbert";
            src = ./config/nvim;
          };
        };
      };

      flake = {
        nixosConfigurations = {
          oezguerisbert-nixos = systems.mkNixOS {
            desktop = true;
            system = "x86_64-linux";
            username = "oezguerisbert";
          };
        };
      };
    };
}
