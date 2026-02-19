{
  den.aspects.apps.provides.media.provides.images.provides.wayscriber.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.wayscriber ];
      systemd.user.services.wayscriber = {
        Unit = {
          Description = "Wayscriber - Screen annotation tool for Wayland";
          Documentation = "https://wayscriber.com";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.wayscriber} --daemon";
          Restart = "on-failure";
          RestartSec = 5;
          RestartPreventExitStatus = 75;
          SuccessExitStatus = 75;
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
