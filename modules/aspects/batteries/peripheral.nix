{ __findFile, lib, ... }:
{
  den.default.includes = [ <batteries/peripheral> ];
  den.aspects.batteries.peripheral = {
    settings = {
      outputs = lib.mkOption {
        description = "Monitors to be configured in the system";
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              position = lib.mkOption {
                description = "Output position";
                type = lib.types.submodule {
                  options = {
                    x = lib.mkOption { type = lib.types.ints.u16; };
                    y = lib.mkOption { type = lib.types.ints.u16; };
                  };
                };
              };
              mode = lib.mkOption {
                description = "Output size";
                type = lib.types.submodule {
                  options = {
                    width = lib.mkOption { type = lib.types.ints.u16; };
                    height = lib.mkOption { type = lib.types.ints.u16; };
                  };
                };
              };
            };
          }
        );
      };
      xkb = lib.mkOption {
        description = "Keyboard configuration";
        type = lib.types.submodule {
          options = {
            layout = lib.mkOption {
              description = "Keyboard layout";
              type = lib.types.str;
            };
            model = lib.mkOption {
              description = "Keyboard model";
              type = lib.types.str;
            };
            options = lib.mkOption {
              description = "Keyboard options";
              type = lib.types.str;
            };
          };
        };
      };
    };
  };
}
