{config, ...}: let
  transparentButtons = config.theme.bar.transparentButtons;

  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  foregroundOnWallpaper = "#${config.theme.textColorOnWallpaper}";
  font = "${config.stylix.fonts.serif.name}";
  fontSizeForHyprpanel = "${toString config.stylix.fonts.sizes.desktop}px";

  rounding = config.theme.rounding;
  border-size = config.theme.border-size;

  gaps-out = config.theme.gaps-out;
  gaps-in = config.theme.gaps-in;

  floating = config.theme.bar.floating;
  transparent = config.theme.bar.transparent;
  position = config.theme.bar.position; # "top" ou "bottom"

  notificationOpacity = 90;

  location = config.var.location;

  homeDir = "/home/${config.var.username}";
in {
  home.file.".config/hyprpanel/modules.json" = {
    force = true;

    text = builtins.toJSON {
      "custom/iplocal" = {
        icon = "🖧";
        label = {};
        execute = "hostname -I";
        tooltip = "Local Ip";
        interval = 15000;
        hideOnEmpty = true;
      };
    };
  };

  home.file.".config/hyprpanel/modules.scss" = {
    force = true;

    text = ''
      $fground: ${foreground};
      $bground: ${background};

      @include styleModule('cmodule-iplocal',
      ('text-color': $fground,
      'icon-color': $fground,
      'icon-background': $bground,
      'label-background': $bground));
    '';
  };
}
