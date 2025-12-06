{config, ...}: {
  programs.wireshark.enable = true;
  users.users."${config.var.username}".extraGroups = ["wireshark"];
}
