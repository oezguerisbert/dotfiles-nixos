{
  description = "Development packages and systems for oezguerisbert. Inspired by 'blackglasses' at TheAltF4Stream";

  inputs = {
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, self, ... }:
    let
      systems = import ./system { inherit inputs; };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          oezguerisbert-nvim = pkgs.vimUtils.buildVimPlugin {
            name = "oezguerisbert";
            src = ./config/nvim;
          };
        };
      };

      flake = {
        darwinConfigurations = {
          oezguerisbert-darwin = systems.mkDarwin {
            system = "x86_64-darwin";
            username = "oezguerisbert";
          };

          work-darwin = systems.mkDarwin {
            system = "aarch64-darwin";
            username = "oisbert";
          };
        };


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
