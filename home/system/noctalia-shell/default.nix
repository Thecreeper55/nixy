{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "noctalia-shell"
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "Spacer";
              width = 20;
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              hideWhenIdle = true;
              maxWidth = 145;
              panelShowAlbunArt = true;
              scrollingMode = "hover";
              showAlbunArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "linear";
            }
            {
              id = "AudioVisualizer";
              colorName = "primary";
              hideWhenIdle = true;
              width = 200;
            }
            {
              id = "Workspace";
              hideUnocupied = false;
              labelMode = "none";
            }
          ];
          center = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = false;
            }
            {
              id = "SystemMonitor";
              conpactMode = true;
              showCpuTemp = true;
              showCpuUsage = true;
              showMemoryUsage = true;
              useMonospaceFont = true;
            }
            {
              id = "Spacer";
              width = 20;
            }
            {
              id = "Volume";
              displayMode = " none";
            }
            {
              id = "Microphone";
              displayMode = "none";
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Battery";
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              tooltipFormat = "HH:mm ddd,MMM dd";
              useMonospaceFont = true;
              usePrimaryColor = true;
              useCustomFont = true;
              customFont = config.stylix.fonts.monospace.name;
            }
            {
              id = "Spacer";
              width = 20;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/${config.var.username}/.config/nixos/hosts/zifra/profile_picture.png";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Valladolid, Spain";
      };
      general = {
        passwordChars = true;
      };
      dock = {
        enabled = true;
        displayMode = "auto_hide";
        dockType = "floating";
      };
      notifications = {
        enabled = true;
      };
      enableBatteryTast = true;
      #notificaciones(spotify)
      enableMediaTast = false;
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "ghostty";
      };
    };
    # this may also be a string or a path to a JSON file.
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        translator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screenshot = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };
  };
}
