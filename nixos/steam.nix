{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      enable32Bit = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    git = {
      lfs.enable = true;
    };
  };

  hardware.opengl.enable = true;

  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  systemd.user.services.monado.environment = {
    STEAM_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
}
