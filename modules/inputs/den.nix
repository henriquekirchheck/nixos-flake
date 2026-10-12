{
  den,
  inputs,
  __findFile,
  ...
}:
{
  flake-file.inputs.den.url = "github:vic/den";
  imports = [ inputs.den.flakeModules.dendritic ];

  _module.args.__findFile = den.lib.__findFile;
  den.default.includes = [
    <den/define-user>
    <den/hostname>
    <den/host-aspects>
  ];

  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };
}
