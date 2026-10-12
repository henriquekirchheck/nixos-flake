{
  den.aspects.apps.security.keyrings.kwallet = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs.kdePackages; [
        kwallet
        kwalletmanager
      ];
      security.pam.services = {
        kde.kwallet = {
          enable = true;
          package = pkgs.kdePackages.kwallet-pam;
        };
        login.kwallet = {
          enable = true;
          package = pkgs.kdePackages.kwallet-pam;
        };
      };
    };
    homeManager = { pkgs, ... }: {
      xdg.portal = {
        extraPortals = [ pkgs.kdePackages.kwallet ];
        config.common."org.freedesktop.impl.portal.Secret" = "kwallet";
      };
    };
  };
}
