{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.nix-citizen.packages.${pkgs.stdenv.hostPlatform.system}.rsi-launcher
  ];

  nix.settings = {
    substituters = ["https://nix-citizen.cachix.org"];
    trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
  };
}
