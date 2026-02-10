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
          extraCompatPackages = with pkgs; [
            proton-ge-bin
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
