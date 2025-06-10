{ pkgs, ... }:
{
  security.doas = {
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
  security.sudo.enable = false;
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "sudo" ''exec doas "$@"'')
  ];
}
