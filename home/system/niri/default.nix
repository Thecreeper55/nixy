{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  border-size = config.theme.border-size;
  gaps-in = config.theme.gaps-in;
  gaps-out = config.theme.gaps-out;
  active-opacity = config.theme.active-opacity;
  inactive-opacity = config.theme.inactive-opacity;
  rounding = config.theme.rounding;
  blur = config.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
  background = "rgba(" + config.lib.stylix.colors.base00 + "EE)";
  active = "rgba(" + config.lib.stylix.colors.base05 + "EE)";
in {
  imports = [
    #./bindings.nix
  ];
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    xcb-util-cursor
    libxcb
    hyprland-qtutils
    adw-gtk3
    hyprshot
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    brightnessctl
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    glib
    direnv
    meson
    niri
    xwayladnd-satellite
  ];

  wayland.windowManager.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri;
    settings = {
      input = {
        keyboard.xkb = {
          layout = keyboardLayout;
          options = "caps:escape";
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
        mouse = {
          accel-profile = "flat";
        };
      };

      spawn-at-startup = [
        {command = "noctalia-shell";}
      ];

      layout = {
        gaps = gaps-out;
        center-focused-column = "never";
        default-column-width = {proportion = 0.5;};

        border = {
          enable = true;
          width = border-size;
          inactive-color = background;
          active-color = active;
        };
        focus-ring.enable = false;
      };

      debug = [
        #for noctalia
        "honor-xdg-activation-with-invalid-serial"
      ];

      programs.niri.settings.environment = {
        # --- Variables Críticas del Desktop ---
        "XDG_CURRENT_DESKTOP" = "niri";
        "XDG_SESSION_DESKTOP" = "niri";
        "XDG_SESSION_TYPE" = "wayland";

        # --- Wayland Toolkit Support ---
        "MOZ_ENABLE_WAYLAND" = "1";
        "ANKI_WAYLAND" = "1";
        "NIXOS_OZONE_WL" = "1"; # Crítico para Chromium/Brave y Electron
        "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
        "SDL_VIDEODRIVER" = "wayland";
        "CLUTTER_BACKEND" = "wayland";

        # --- Qt Configuration ---
        "QT_QPA_PLATFORM" = "wayland;xcb";
        "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
        "QT_QPA_PLATFORMTHEME" = "gtk3";
        "DISABLE_QT5_COMPAT" = "0";

        # --- Hardware & Renderizado ---
        # Nota: Niri usa OpenGL/Vulkan internamente, pero no suele requerir WLR_RENDERER manual.
        # Si tienes problemas con el cursor (desaparición), esta es la equivalente a WLR_NO_HARDWARE_CURSORS:
        "NIRI_RENDERER_NO_HARDWARE_CURSORS" = "1";

        # --- Miscelánea ---
        "DIRENV_LOG_FORMAT" = "";
      };
    };
  };
}
