{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.wayscriber.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
