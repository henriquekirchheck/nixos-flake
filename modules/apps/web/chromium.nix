{
  den.aspects.apps.provides.web.provides.chromium = {
    nixos.programs.chromium = {
      enable = true;
      extraOpts = {
        "ExtensionManifestV2Availability" = 2;
      };
    };
    homeManager =
      { pkgs, ... }:
      {
        programs.chromium = {
          enable = true;
          dictionaries = with pkgs.hunspellDictsChromium; [
            en_US
          ];
          extensions = [
            "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
            "nngceckbapebfimnlniiiahkandclblb" # bitwarden
          ];
        };
      };
  };
}
