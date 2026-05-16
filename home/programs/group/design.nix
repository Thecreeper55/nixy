{
  pkgs-stable,
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    # inputs.affinity-nix.overlays.default
  ];
  home.packages = [
    inputs.affinity-nix.packages.${pkgs.system}.affinity-v3
  ];
}
