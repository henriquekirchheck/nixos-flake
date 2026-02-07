{
  den.aspects.hardware.provides.bluetooth = {
    nixos.hardware.bluetooth.enable = true;
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bluetui ];
        systemd.user.services.mpris-proxy = {
          description = "Mpris proxy";
          after = [
            "network.target"
            "sound.target"
          ];
          wantedBy = [ "default.target" ];
          serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
        };
      };
  };
}
