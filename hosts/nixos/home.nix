{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/brave
    ../../home/programs/proton
    ../../home/programs/proton/auto-start-vpn.nix
    ../../home/programs/ghostty
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/git/lazygit.nix
    ../../home/programs/git/signing.nix # Change the key or remove this file
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/discord
    ../../home/programs/direnv
    ../../home/programs/nixy
    ../../home/programs/nightshift

    ../../home/programs/group/basic-apps.nix
    ../../home/programs/group/cybersecurity.nix
    ../../home/programs/group/dev.nix
    ../../home/programs/group/misc.nix

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/noctalia-shell
    ../../home/system/hyprpaper
    ../../home/system/mime
    ../../home/system/udiskie

    ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      mpv #Video Player
      stirling-pdf
      calibre
      krita
      godot
      android-studio
      trilium-desktop

      # Dev
      jdk
      rustup
      sqlite
      jetbrains.idea
      direnv

      # Backup
      vivaldi
    ];

    # Import my profile picture, used by the celestia dashboard
    file.".face.icon" = {source = ./profile_picture.png;};

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
