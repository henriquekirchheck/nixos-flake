{
  den.aspects.apps.provides.keyrings.provides.kwallet = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs.kdePackages; [
          kwallet
          kwallet-pam
          kwalletmanager
        ];
        security.pam.services =
          let
            kwallet = {
              enable = true;
              package = pkgs.kdePackages.kwallet-pam;
            };
          in
          {
            kde = { inherit kwallet; };
            login = { inherit kwallet; };
          };
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.seahorse ];
        xdg.portal = {
          extraPortals = [ pkgs.kdePackages.kwallet ];
          config.common."org.freedesktop.impl.portal.Secret" = "kwallet";
        };
      };
  };
}
