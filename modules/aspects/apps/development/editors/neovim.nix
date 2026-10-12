{ inputs, ... }:
{
  flake-file.inputs = {
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.apps.development.editors.neovim = {
    nixpkgs-overlays = _: [ inputs.neovim-nightly-overlay.overlays.default ];

    homeManager = {
      programs.neovim.enable = true;
    };

    cacheHome = {
      directories = [ ".local/state/nvim" ];
    };
  };
}
