{ config, pkgs, ... }:

{
  security.doas.enable = false;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [{
      groups = [ "wheel" ];
      commands = [ "ALL" ];
    }];
  };
}
