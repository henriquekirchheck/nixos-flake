{ config, ... }:

{
  programs.nixvim = (import ./config/nixvim.nix) // { enable = true; };
}
