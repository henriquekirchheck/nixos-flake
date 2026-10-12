{
  den.aspects.apps.ssh = {
    homeManager = {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."Host *".AddKeysToAgent = "4h";
      };
    };

    persistHome = _: {
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
