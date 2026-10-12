{ den, ... }: {
  den.schema.flake-system.includes = [ den.policies.system-to-flake-parts ];
}
