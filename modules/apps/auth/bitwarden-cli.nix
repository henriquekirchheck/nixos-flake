{
  den.aspects.apps.provides.auth.provides.bitwarden-cli = {
    description = "Bitwarden CLI";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bitwarden-cli ];
      };
  };
}
