{ inputs }: {
  mkDarwin = import ./darwin { inherit inputs; };
  mkLinux = import ./linux { inherit inputs; };
  mkNixOS = import ./nixos { inherit inputs; };
}
