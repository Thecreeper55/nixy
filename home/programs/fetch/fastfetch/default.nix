{pkgs, ...}: {
  home.packages = with pkgs; [fastfetch];
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    logo = {
      type = "auto";
      source = "NixOs";
      padding = {
        right = 1;
      };
    };
    display = {
      size = {
        binaryPrefix = "si";
      };
      key = {
        width = 13;
      };
      constants = [
        "──────────────────"
        "└──────────────────────────────────────────────┘"
      ];
      color = "blue";
      separator = ": ";
    };
    modules = [
      {
        type = "custom";
        format = "┌{$1} HARDWARE {$1}┐";
      }
      {
        type = "host";
        key = " Host";
      }
      {
        type = "cpu";
        key = " CPU";
        format = "{name} Cores -> {cores-logical} | {freq-max}";
      }
      {
        type = "gpu";
        key = " GPU";
        format = "{name}";
      }
      {
        type = "disk";
        key = " Disk";
        format = "{size-used} -> {size-total} | {filesystem}";
      }
      {
        type = "custom";
        format = "{$2}";
      }
      {
        type = "break";
      }
      {
        type = "custom";
        format = "┌{$1} SOFTWARE {$1}┐";
      }
      {
        type = "os";
        key = " OS";
        format = "{name} {version}";
      }
      {
        type = "kernel";
        key = " Kernel";
      }
      {
        type = "packages";
        key = " Packages";
      }
      {
        type = "terminal";
        key = " Terminal";
      }
      {
        type = "shell";
        key = " Shell";
      }
      {
        type = "wm";
        key = " WM";
      }
      {
        type = "cursor";
        key = " Cursor";
      }
      {
        type = "custom";
        format = "{$2}";
      }
      {
        type = "break";
      }
      {
        type = "colors";
      }
    ];
  };
}
