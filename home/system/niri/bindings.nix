{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors;

  # Lógica de menús con wlr-which-key
  mkMenu = menu: let
    configFile =
      pkgs.writeText "config.yaml"
      (lib.generators.toYAML {} {
        anchor = "bottom-right";
        border = "#${colors.base0D}80";
        background = "#${colors.base01}EE";
        color = "#${colors.base05}";
        margin_right = 15;
        margin_bottom = 15;
        rows_per_column = 5;
        inherit menu;
      });
  in
    pkgs.writeShellScriptBin "menu" ''
      exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
in {
  wayland.windowManager.niri.settings.binds = {
    # --- Applications & Menus ---
    "Mod+Shift+A".action.spawn = [
      (lib.getExe (mkMenu [
        {
          key = "a";
          desc = "Proton Authenticator";
          cmd = "env WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.proton-authenticator}/bin/proton-authenticator";
        }
        {
          key = "p";
          desc = "Proton Pass";
          cmd = "${pkgs.proton-pass}/bin/proton-pass";
        }
        {
          key = "v";
          desc = "Proton VPN";
          cmd = "${pkgs.protonvpn-gui}/bin/protonvpn-app";
        }
        {
          key = "o";
          desc = "Obsidian";
          cmd = "${pkgs.obsidian}/bin/obsidian";
        }
        {
          key = "s";
          desc = "Signal";
          cmd = "${pkgs.signal-desktop}/bin/signal-desktop";
        }
        {
          key = "t";
          desc = "TickTick";
          cmd = "${pkgs.ticktick}/bin/ticktick";
        }
        {
          key = "b";
          desc = "Brave";
          cmd = "${pkgs.brave}/bin/brave";
        }
        {
          key = "i";
          desc = "Brave (Private)";
          cmd = "${pkgs.brave}/bin/brave --incognito";
        }
      ]))
    ];

    "Mod+B".action.spawn = ["uwsm" "app" "--" "${pkgs.brave}/bin/brave"];
    "Mod+Shift+B".action.spawn = [
      (lib.getExe (mkMenu [
        {
          key = "m";
          desc = "Proton Mail";
          cmd = "${pkgs.brave}/bin/brave 'https://mail.proton.me/u/2/inbox'";
        }
        {
          key = "c";
          desc = "Proton Calendar";
          cmd = "${pkgs.brave}/bin/brave 'https://calendar.proton.me/u/2'";
        }
        {
          key = "l";
          desc = "Proton Lumo";
          cmd = "${pkgs.brave}/bin/brave 'https://lumo.proton.me/u/2'";
        }
        {
          key = "d";
          desc = "Proton Drive";
          cmd = "${pkgs.brave}/bin/brave 'https://drive.proton.me/u/2/'";
        }
        {
          key = "G";
          desc = "Google Gemini";
          cmd = "${pkgs.brave}/bin/brave 'https://gemini.google.com/'";
        }
        {
          key = "g";
          desc = "Github";
          cmd = "${pkgs.brave}/bin/brave 'https://github.com/'";
        }
        {
          key = "n";
          desc = "MyNixos";
          cmd = "${pkgs.brave}/bin/brave 'https://mynixos.com/'";
        }
      ]))
    ];

    # --- Power Menu ---
    "Mod+Shift+X".action.spawn = [
      (lib.getExe (mkMenu [
        {
          key = "l";
          desc = "Lock";
          cmd = "loginctl lock-session";
        }
        {
          key = "s";
          desc = "Suspend";
          cmd = "systemctl suspend";
        }
        {
          key = "r";
          desc = "Reboot";
          cmd = "systemctl reboot";
        }
        {
          key = "p";
          desc = "Power Off";
          cmd = "systemctl poweroff";
        }
        {
          key = "n";
          desc = "Nightshift";
          cmd = "nightshift-toggle";
        }
      ]))
    ];

    # --- Quick Launch ---
    "Mod+Return".action.spawn = ["uwsm" "app" "--" "${pkgs.ghostty}/bin/ghostty"];
    "Mod+E".action.spawn = ["uwsm" "app" "--" "${pkgs.thunar}/bin/thunar"];
    "Mod+Shift+E".action.spawn = ["sh" "-c" "pkill fuzzel || caelestia emoji -p"];

    # --- Windows & Navigation ---
    "Mod+Q".action.close-window = [];
    "Mod+F".action.maximize-column = [];
    "Mod+Shift+F".action.toggle-window-floating = [];

    # Navegación estilo Vim (HJKL)
    "Mod+H".action.focus-column-left = [];
    "Mod+L".action.focus-column-right = [];
    "Mod+K".action.focus-window-or-workspace-up = [];
    "Mod+J".action.focus-window-or-workspace-down = [];

    # Movimiento de columnas
    "Mod+Shift+H".action.move-column-left = [];
    "Mod+Shift+L".action.move-column-right = [];

    # --- Workspaces (1-9) ---
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;

    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;

    # --- Media & Hardware Keys ---
    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+"];
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
    "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

    "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "10%+"];
    "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];

    # --- Mouse Binds ---
    "Mod+MouseLeft".action.set-cursor-position-with-mod-key-release = [];
  };
}
