{ pkgs }:
{
  beat-detector = pkgs.callPackage ./beat-detector { };

  modules = import ./modules;
  hmModules = import ./hmModules;
}
