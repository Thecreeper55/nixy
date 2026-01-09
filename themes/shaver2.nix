{
  lib,
  pkgs,
  config,
  ...
}: {
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 10;
      gaps-in = 8;
      gaps-out = 8 * 2;
      active-opacity = 0.96;
      inactive-opacity = 0.94;
      blur = true;
      border-size = 2;
      animation-speed = "fast"; # "fast" | "medium" | "slow"
      fetch = "fastfetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"
      textColorOnWallpaper =
        config.lib.stylix.colors.base01; # Color of the text displayed on the wallpaper (Lockscreen, display manager, ...)
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # tarot
    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "0e091d";
      base01 = "2a153c";
      base02 = "4b2054";
      base03 = "74316b";
      base04 = "8c406f";
      base05 = "aa556f";
      base06 = "c4686d";
      base07 = "dc8f7c";
      base08 = "c53253";
      base09 = "ea4d60";
      base0A = "ff6565";
      base0B = "a68e5a";
      base0C = "8c9785";
      base0D = "6e6080";
      base0E = "a45782";
      base0F = "984d51";
    };

    cursor = {
      name = "rose-pine-hyprcursor";
      package = pkgs.rose-pine-hyprcursor;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.monocraft;
        name = "monocraft";
      };
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/cat-watching-the-star_pixelart_purple_static.png";
      sha256 = "sha256-P8gCiCC9CZPJyGL4kpvAaOqlNor010s/BUA0muBVfK0";
    };
  };
}
