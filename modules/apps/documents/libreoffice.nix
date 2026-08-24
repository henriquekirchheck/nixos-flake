{
  den.aspects.apps.provides.documents.provides.libreoffice.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.pt_BR
        hunspellDicts.en_US
      ];
    };
}
