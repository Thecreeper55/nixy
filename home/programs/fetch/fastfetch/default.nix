{pkgs, ...}: {
  home.packages = with pkgs; [fastfetch];
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    logo = {
      source = "NixOs";
      padding = {
        right = 1;
      };
    };
    display = {
      size = {
        binaryPrefix = "si";
      };
      color = "blue";
      separator = ": ";
    };
    modules = [
      {
        type = "custom";
        format = "┌────────────────── HARDWARE ───────────────────┐";
      }
      {
        type = "host";
        key = " Host";
      }
      {
        type = "cpu";
        key = " CPU";
      }
      {
        type = "gpu";
        key = " GPU";
      }
      {
        type = "disk";
        key = " Disk";
      }
      {
        type = "custom";
        format = "└───────────────────────────────────────────────┘";
      }
      {
        type = "break";
      }
      {
        type = "custom";
        format = "┌────────────────── SOFTWARE ───────────────────┐";
      }
      {
        type = "os";
        key = " OS";
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
        format = "└───────────────────────────────────────────────┘";
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
