{ config, pkgs, ... }:

{
  # Doas instead of sudo
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [{
      groups = [ "wheel" ];
      keepEnv = true;
      persist = true;
    }];
  };

  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];
}
