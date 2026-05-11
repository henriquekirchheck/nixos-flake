{ den, ... }:
{
  den.aspects.utils.provides.hostname = {
    nixos =
      { host }:
      {
        networking.hostName = host.hostName;
      };
  };
  den.default.includes = [ den.aspects.utils._.hostname ];
}
