{ __findFile, ... }:
{
  den.default.includes = [ <apps/security/polkit> ];
  den.aspects.apps.security.polkit = {
    nixos.security.polkit.enable = true;
  };

  den.aspects.apps.security.polkit.kde = {
    homeManager = { pkgs, ... }: {
      systemd.user.services.kde-polkit = {
        Unit = {
          Description = "KDE PolicyKit Authentication Agent";
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.service" ];
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
