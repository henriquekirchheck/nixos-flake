{
  inputs,
  lib,
  den,
  ...
}:
{
  den.default.includes = [ den.aspects.disko ];
  imports = [ inputs.disko.flakeModules.default ];
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko = {
    description = ''
      integrates home-manager into nixos/darwin OS classes.

      usage:

        for using home-manager in just a particular host:

          den.aspects.my-laptop.includes = [ den._.home-manager ];

        for enabling home-manager by default on all hosts:

          den.default.includes = [ den._.home-manager ];

      Does nothing for hosts that have no users with `homeManager` class.
      Expects `inputs.home-manager` to exist. If `<host>.hm-module` exists
      it is the home-manager.{nixos/darwin}Modules.home-manager.

      For each user resolves den.aspects.''${user.aspect} and imports its homeManager class module.
    '';

    __functor =
      _:
      den.lib.take.exactly (
        { OS, host }:
        let
          diskoClass = "disko";
          aspect.${host.class}.imports = [
            inputs.disko.nixosModules.disko
            (OS.resolve { class = diskoClass; })
          ];
        in
        aspect
      );
  };
}

# {
#   inputs,
#   lib,
#   den,
#   ...
# }:
# let
#    homeManager =
#     { HM-OS-HOST }:
#     let
#       inherit (HM-OS-HOST) OS host;

#       hmClass = "homeManager";
#       hmUsers = builtins.filter (u: u.class == hmClass) (lib.attrValues host.users);

#       hmUserModule =
#         user:
#         let
#           HM = den.aspects.${user.aspect};
#           aspect = HM {
#             HM-OS-USER = {
#               inherit
#                 OS
#                 HM
#                 host
#                 user
#                 ;
#             };
#           };
#           module = aspect.resolve { class = hmClass; };
#         in
#         module;

#       users = map (user: {
#         name = user.userName;
#         value.imports = [ (hmUserModule user) ];
#       }) hmUsers;

#       hmModule = host.hm-module or inputs.home-manager."${host.class}Modules".home-manager;
#       aspect.${host.class} = {
#         imports = [ hmModule ];
#         home-manager.users = lib.listToAttrs users;
#       };

#     in
#     aspect;

# in
# {
#   den.provides.home-manager = {
#     inherit description;
#     __functor = _: den.lib.take.exactly homeManager;
#   };
# }
