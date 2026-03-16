# Systemd-boot configuration for NixOS and Windows
{pkgs, ...}: {
  fileSystems."/boot/boot-windows" = {
    device = "/dev/nvme1n1p2";
    fsType = "vfat";
  };

  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 8;

        extraEntries = {
          "windows.conf" = ''
            title Windows
            efi /boot/boot-windows/EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages =
      pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;

    # plymouth = {
    #   enable = true;
    #   theme = lib.mkForce "cuts_alt";
    #   themePackages = with pkgs; [
    #     (adi1090x-plymouth-themes.override {
    #       selected_themes = ["cuts_alt"];
    #     })
    #   ];
    # };
  };

  # To avoid systemd services hanging on shutdown
  systemd.settings.Manager = {DefaultTimeoutStopSec = "10s";};
}
