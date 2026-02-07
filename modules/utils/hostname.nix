{ den, ... }:
{
  den.aspects.utils.provides.hostname = (
    den.lib.take.exactly (
      { OS, host }:
      den.lib.take.unused OS {
        nixos.networking.hostName = host.hostName;
      }
    )
  );
  den.default.includes = [ den.aspects.utils._.hostname ];
}
