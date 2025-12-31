{ inputs, pkgs, ... }:

{
  home.packages = [ inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
