{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    ../../themes/shaver.nix
  ];

  config.var = {
    hostname = "zifra";
    username = "thecreeper55";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Valladolid";
    timeZone = "Europe/Madrid";
    defaultLocale = "es_ES.UTF-8";
    extraLocale = "es_ES.UTF-8";

    git = {
      username = "Thecreeper55";
      email = "Thecreeper55@mail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
