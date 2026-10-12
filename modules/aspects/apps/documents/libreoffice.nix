{
  den.aspects.apps.documents.libreoffice = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.pt_BR
        hunspellDicts.en_US
      ];
    };

    cacheHome = _: {
      directories = [ ".config/libreoffice" ];
    };
  };
}
