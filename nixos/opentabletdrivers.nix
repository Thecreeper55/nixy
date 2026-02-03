{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Required for OpenTabletDriver to function
  hardware.uinput.enable = true;
  boot.kernelModules = ["uinput"];
}
