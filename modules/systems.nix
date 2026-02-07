{ den, ... }:
{
  systems = builtins.attrNames den.hosts;
}
