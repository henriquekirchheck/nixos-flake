{ __findFile, ... }:
{
  den.default.includes = [ <userborn> ];
  den.aspects.userborn = {
    nixos = { host, lib, ... }: {
      services.userborn = {
        enable = true;
        passwordFilesLocation = lib.mkIf (host.hasAspect <sops>) "/var/lib/nixos";
      };
      users.mutableUsers = false;
      users.users.root.password = "1234";
    };
  };
}
