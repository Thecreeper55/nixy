{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors;

  # Helper para no repetir el comando base
  nCall = "noctalia-shell ipc call";

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
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$shiftMod" = "SUPER_SHIFT";

    bind =
      [
        # Applications
        ("$shiftMod, A, exec, "
          + lib.getExe (mkMenu [
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
              cmd = "${pkgs.proton-vpn}/bin/protonvpn-app";
            }
            {
              key = "c";
              desc = "Proton Calendar";
              cmd = "${pkgs.qutebrowser}/bin/qutebrowser 'https://calendar.proton.me/'";
            }
            {
              key = "m";
              desc = "Proton Mail";
              cmd = "${pkgs.qutebrowser}/bin/qutebrowser 'https://mail.proton.me/'";
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
              desc = "Brave (Private Window)";
              cmd = "${pkgs.brave}/bin/brave --incognito";
            }
          ]))

        # Web links
        "$mod,B, exec,  uwsm app -- ${pkgs.brave}/bin/brave" # Browser (Brave)
        ("$shiftMod, B, exec, "
          + lib.getExe (mkMenu [
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

        # Power
        "$mod, X, exec, ${nCall} sessionMenu toggle" # Powermenu
        ("$shiftMod, X, exec, "
          + lib.getExe (mkMenu [
            {
              key = "l";
              desc = "Lock";
              cmd = "hyprctl dispatch  exec '${nCall} lockScreen lock'";
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
            {
              key = "c";
              desc = "Restart caelestia";
              cmd = "hyprctl dispatch exec 'noctalia-shell kill | sleep 1 | noctalia-shell'";
            }
          ]))

        # Quick launch
        "$mod,RETURN, exec, uwsm app -- ${pkgs.ghostty}/bin/ghostty" # Ghostty (terminal)
        "$mod,E, exec,  uwsm app -- ${pkgs.thunar}/bin/thunar" # Thunar
        "$shiftMod, E, exec, pkill fuzzel || ${nCall} launcher emoji" # Emoji picker
        "$mod, SPACE, exec, ${nCall} launcher toggle" # Launcher
        "$mod, N, exec, ${nCall} notifications toggleHistory" # Sidebar (Notifications, quick actions)
        "$mod, D, exec, ${nCall} controlCenter toggle" # Dashboard

        # Windows
        "$mod,Q, killactive," # Close window
        "$mod,F, fullscreen" # Toggle Fullscreen
        "$shiftMod,F, togglefloating," # Toggle Floating

        # Focus Windows
        "$mod,H, movefocus, l" # Move focus left
        "$mod,J, movefocus, d" # Move focus Down
        "$mod,K, movefocus, u" # Move focus Up
        "$mod,L, movefocus, r" # Move focus Right
        "$shiftMod,H, focusmonitor, -1" # Focus previous monitor
        "$shiftMod,J, layoutmsg, removemaster" # Remove from master
        "$shiftMod,K, layoutmsg, addmaster" # Add to master
        "$shiftMod,L, focusmonitor, 1" # Focus next monitor

        # Utilities
        "$shiftMod, S, exec, ${nCall} plugin:screenshot takeScreenshot output" # Capture region (freeze)
        ", Print, exec, ${nCall} plugin:screenshot takeScreenshot region" # Capture region (freeze)
        "$shiftMod+Alt, S, exec, ${nCall} plugin:screenshot takeScreenshot region" # Capture region
      ]
      ++ (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          "$mod,code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
        ])
        9));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      # Brightness
      ", XF86MonBrightnessUp, exec, ${nCall} brightness up"
      ", XF86MonBrightnessDown, exec, ${nCall} brightness down"

      # Media
      ", XF86AudioPlay, exec, ${nCall} media playPause"
      ", XF86AudioPause, exec, ${nCall} media playPause"
      ", XF86AudioNext, exec, ${nCall} media next"
      ", XF86AudioPrev, exec, ${nCall} media previous"
      ", XF86AudioStop, exec, ${nCall} media pause"

      # Sound
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindin = [
      # Launcher
      "$mod, mouse:272, exec, ${nCall} launcher close"
      "$mod, mouse:273, exec, ${nCall} launcher close"
      "$mod, mouse:274, exec, ${nCall} launcher close"
      "$mod, mouse:275, exec, ${nCall} launcher close"
      "$mod, mouse:276, exec, ${nCall} launcher close"
      "$mod, mouse:277, exec, ${nCall} launcher close"
      "$mod, mouse_up, exec, ${nCall} launcher close"
      "$mod, mouse_down, exec, ${nCall} launcher close"
    ];
  };
}
