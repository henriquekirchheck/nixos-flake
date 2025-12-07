{ inputs, pkgs, ... }:

{
  imports = [ inputs.musnix.nixosModules.musnix ];
  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  environment.systemPackages = with pkgs; [ yabridge yabridgectl ];
}
