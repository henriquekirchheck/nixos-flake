{ __findFile, inputs, ... }:
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.quirks = {
    secrets.description = "Secret Path needed for system";
    secretsHome.description = "Secret Path needed for user";
    templates.description = "Template needed for system";
    templatesHome.description = "Template needed for user";
  };

  den.aspects.sops = {
    includes = [
      <sops/collectSecrets>
      <sops/collectTemplates>
    ];
    nixos = { host, lib, ... }: {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      #sops.age.keyFile = lib.mkIf (host.hasAspect <sops>) "/persist/var/lib/sops-nix/key.txt";
      sops.age.keyFile = "/var/lib/sops-nix/key.txt";
    };
    persist = _: {
      files = [
        {
          file = "/var/lib/sops-nix/key.txt";
          how = "symlink";
          inInitrd = true;
        }
      ];
    };
    homeManager =
      {
        host,
        lib,
        config,
        ...
      }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];
        #sops.age.keyFile = lib.mkIf (host.hasAspect <sops>) "/persist${config.xdg.configHome}/sops/age/keys.txt";
        sops.age.keyFile = "${config.xdg.configHome}/sops/age/key.txt";
      };
    persistHome = _: {
      files = [
        {
          file = ".config/sops/age/key.txt";
          how = "symlink";
          inInitrd = true;
        }
      ];
    };
  };

  den.aspects.sops.systemFile = file: {
    nixos.sops.defaultSopsFile = file;
  };
  den.aspects.sops.userFile = file: {
    homeManager.sops.defaultSopsFile = file;
  };

  den.aspects.sops.collectSecrets = {
    nixos = { secrets, lib, ... }: {
      sops.secrets = lib.mkMerge (map (x: { ${x} = { }; }) secrets);
    };
    homeManager = { secretsHome, lib, ... }: {
      sops.secrets = lib.mkMerge (map (x: { ${x} = { }; }) secretsHome);
    };
  };
  den.aspects.sops.collectTemplates = {
    nixos = { templates, lib, ... }: {
      sops.templates = lib.mkMerge templates;
    };
    homeManager = { templatesHome, lib, ... }: {
      sops.templates = lib.mkMerge templatesHome;
    };
  };

  flake.lib = {
    toSops =
      pkgs: name: sops:
      pkgs.runCommand name
        {
          buildInputs = with pkgs; [ yj ];
          sops = builtins.toJSON { creation_rules = builtins.attrValues sops.rules; };
          passAsFile = [ "sops" ];
        }
        ''
          yj -jy < "$sopsPath" > $out
        '';
  };
}
