{
  pkgs,
  inputs,
  ...
}:

{
  nix = {
    package = pkgs.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
      nixos-config.flake = inputs.self;
    };
    channel.enable = false;
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "home-manager=${inputs.home-manager}"
      "nixos-config=${inputs.self}"
      "${inputs.nixpkgs}"
    ];
  };
  environment.shellAliases.nixrepl = "nix repl --expr 'builtins.getFlake \"${inputs.self}\"'";
}
