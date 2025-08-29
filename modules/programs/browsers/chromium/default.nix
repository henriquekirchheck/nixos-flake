{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    dictionaries = with pkgs.hunspellDictsChromium; [
      en_US
    ];
    extraOpts = {
      "ExtensionManifestV2Availability" = 2;
    };

    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
    ];
  };
}
