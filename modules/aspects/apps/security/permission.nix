{ den, ... }: {
  den.default.includes = [ den.aspects.apps.security.permission ];
  den.aspects.apps.security.permission = {
    nixos = { lib, ... }: {
      security = {
        sudo.enable = lib.mkDefault false;
        sudo-rs.enable = lib.mkDefault false;
        doas.enable = lib.mkDefault false;
      };
    };
  };

  den.aspects.apps.security.permission.sudo-rs = {
    nixos.security.sudo-rs = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          commands = [ "ALL" ];
        }
      ];
    };
  };

  den.aspects.apps.security.permission.doas = {
    nixos.security.doas = {
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
    sudo-alias.nixos = { pkgs, ... }: {
      environment.systemPackages = [ (pkgs.writeShellScriptBin "sudo" ''exec doas "$@"'') ];
    };
  };
}
