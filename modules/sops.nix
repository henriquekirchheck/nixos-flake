{
  perSystem =
    { pkgs, ... }:
    let
      toSops =
        name: sops:
        pkgs.runCommand name
          {
            buildInputs = with pkgs; [ yj ];
            sops = builtins.toJSON { creation_rules = builtins.attrValues sops.rules; };
            passAsFile = [ "sops" ];
          }
          ''
            yj -jy < "$sopsPath" > $out
          '';
    in
    {
      files.files = [
        {
          path_ = ".sops.yaml";
          drv = toSops "sops.yaml" rec {
            keys = {
              henrique = "age1cmx764yuualp623t3urnuan747kpxpyacr7ghtsy5huwdqv6ps4qdw3xs6";
              pc = "age189jem67f5uc8hwsrmc0ac2x3fxugucdclmhe4usjmjnydw03vufsx38w9c";
              laptop = "age1kk0s3r3a7meuvz8xhr9nc2zrxx3v53rdf5y832y9fm6fq5v4x3dsmd8nss";
            };
            rules = {
              pc = {
                path_regex = "modules/hosts/pc/secrets/.*$";
                key_groups = [
                  {
                    age = [
                      keys.henrique
                      keys.pc
                    ];
                  }
                ];
              };
              laptop = {
                path_regex = "modules/hosts/laptop/secrets/.*$";
                key_groups = [
                  {
                    age = [
                      keys.henrique
                      keys.laptop
                    ];
                  }
                ];
              };
              henrique = {
                path_regex = "modules/users/henrique/secrets/.*$";
                key_groups = [
                  {
                    age = [
                      keys.henrique
                      keys.laptop
                      keys.pc
                    ];
                  }
                ];
              };
            };
          };
        }
      ];
    };
}
