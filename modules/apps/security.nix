{ den, ... }:
{
  den.default.includes = [ den.aspects.apps._.security._.permission ];
  den.aspects.apps.provides.security.provides.permission = {
    description = "Permission";

    nixos =
      { lib, ... }:
      {
        security.sudo.enable = lib.mkDefault false;
        security.sudo-rs.enable = lib.mkDefault false;
        security.doas.enable = lib.mkDefault false;
      };

    provides =
      let
        sudoConfig = {
          enable = true;
          wheelNeedsPassword = true;
          extraRules = [
            {
              groups = [ "wheel" ];
              commands = [ "ALL" ];
            }
          ];
        };
      in
      {
        sudo-rs.nixos.security.sudo-rs = sudoConfig;
        sudo.nixos.security.sudo = sudoConfig;
        doas = {
          nixos.security.doas = {
            enable = true;
            wheelNeedsPassword = true;
            extraRules = [
              {
                groups = [ "wheel" ];
                keepEnv = true;
                persist = true;
              }
            ];
          };
          provides.sudo-alias.homeManager =
            { pkgs, ... }:
            {
              home.packages = [ (pkgs.writeShellScriptBin "sudo" ''exec doas "$@"'') ];
            };
        };
      };
  };
}
