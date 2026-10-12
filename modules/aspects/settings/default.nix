{ den, lib, ... }: {
  den.reservedKeys = [ "settings" ];
  den.schema.host.imports = [
    {
      options.settings = lib.mkOption {
        type = import ./_type.nix { inherit den lib; };
        default = { };
        description = "Per-aspect typed settings";
      };
    }
  ];
}
