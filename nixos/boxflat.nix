{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    boxflat
  ];

  services.udev.packages = with pkgs; [
    boxflat
  ];
  users.users."${config.var.username}".extraGroups = [
    "input"
    "plugdev"
  ];
}
