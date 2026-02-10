{ den, ... }:
{
  den.default.includes = [
    (den.aspects.utils._.nixpkgs._.add-substituter {
      substituter = "https://henriquekh.cachix.org";
      public-key = "henriquekh.cachix.org-1:i7FaksyOcbvWqd6tdLHOO0/XfWCLRbk2P1nc94JcPlg=";
    })
    (den.aspects.utils._.nixpkgs._.add-substituter {
      substituter = "https://nix-community.cachix.org";
      public-key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    })
  ];
}
