{ den, ... }:
{
  den.default.includes = [ den.aspects.apps._.permission ];
  den.aspects.apps.provides.permission = {
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
        doas.nixos =
          { pkgs }:
          {
            security.doas = {
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
            environment.systemPackages = [
              (pkgs.writeShellScriptBin "sudo" ''exec doas "$@"'')
            ];
          };
      };
  };
}
