{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.nix-citizen.packages.${pkgs.stdenv.hostPlatform.system}.rsi-launcher
  ];
}
