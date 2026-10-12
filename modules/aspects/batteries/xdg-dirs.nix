{
  den.aspects.batteries.xdg-dirs =
    {
      music,
      videos,
      pictures,
      templates,
      download,
      documents,
      desktop,
      publicShare,
      projects,
    }:
    {
      homeManager =
        { config, ... }:
        let
          appendHome = dir: if dir != null then "${config.home.homeDirectory}/${dir}" else null;
        in
        {
          xdg = {
            enable = true;
            userDirs = {
              enable = true;
              createDirectories = true;

              music = appendHome music;
              videos = appendHome videos;
              pictures = appendHome pictures;
              templates = appendHome templates;
              download = appendHome download;
              projects = appendHome projects;
              documents = appendHome documents;
              desktop = appendHome desktop;
              publicShare = appendHome publicShare;
            };
          };
        };

      persistHome = _: {
        directories = [
          music
          videos
          pictures
          templates
          download
          documents
          desktop
          publicShare
          projects
        ];
      };
    };
}
