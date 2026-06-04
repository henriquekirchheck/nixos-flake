{ den, ... }:
{
  den.aspects.apps.provides.games.provides.steam = {
    includes = [
      (den._.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              MANGOHUD = "1";
              MANGOHUD_CONFIG = "read_cfg,no_display";
              VKD3D_CONFIG = "dxr,dxr12";
              PROTON_ENABLE_WAYLAND = "1";
              PROTON_NO_WM_DECORATION = "1";
              PROTON_LOCAL_SHADER_CACHE = "1";
            };
          };
          extraCompatPackages = with pkgs; [
            proton-ge-bin
            dwproton-bin
            steam-play-none
          ];
          protontricks.enable = true;

          dedicatedServer.openFirewall = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extest.enable = true;
        };
      };
  };
}
