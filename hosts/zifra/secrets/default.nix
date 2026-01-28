# Those are my secrets, encrypted with sops
# You shouldn't import this file, unless you edit it
{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/home/${config.var.username}/.config/sops/age/keys.txt";

    defaultSopsFile = ./secrets.yaml;
    secrets = {
      signing-key = {path = "/home/${config.var.username}/.ssh/key";};
      signing-pub-key = {path = "/home/${config.var.username}/.ssh/key.pub";};
    };
  };

  home.file.".config/nixos/.sops.yaml".text = ''
    keys:
      - &primary age16y46rldasx8gcw2nmnxnwgv280h5xll3y6q74ejyp7k3vrtg94mqj30dva
    creation_rules:
      - path_regex: hosts/zifra/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary
      - path_regex: hosts/nixos/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary

  '';

  systemd.user.services.mbsync.Unit.After = ["sops-nix.service"];
  home.packages = with pkgs; [sops age];

  wayland.windowManager.hyprland.settings.exec-once = ["systemctl --user start sops-nix"];
}
