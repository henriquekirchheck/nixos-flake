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
}
