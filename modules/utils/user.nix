{ den, ... }:
{
  den.default.includes = [ den._.define-user ];

  den.aspects.utils.provides.user = {
    description = "User Utilities";
    provides = {
      password =
        {
          key,
          sopsFile,
          ...
        }:
        { user, ... }:
        let
          secret = "${user.userName}-password";
        in
        {
          description = "Add user password secret";
          includes = [ den.aspects.apps._.sops ];
          nixos =
            { config, ... }:
            {
              sops.secrets.${secret} = {
                inherit key sopsFile;
                format = "yaml";
                neededForUsers = true;
              };
              users.users.${user.userName} = {
                hashedPasswordFile = config.sops.secrets.${secret}.path;
              };
            };
        };
      xdg-dirs =
        {
          music ? null,
          videos ? null,
          pictures ? null,
          templates ? null,
          download ? null,
          documents ? null,
          desktop ? null,
          publicShare ? null,
          dotfiles ? null,
        }:

        {
          homeManager =
            { config, lib, ... }:
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
                  documents = appendHome documents;
                  desktop = appendHome desktop;
                  publicShare = appendHome publicShare;
                  extraConfig = lib.mkIf (dotfiles != null) {
                    DOTFILES = appendHome dotfiles;
                  };
                };
              };
            };
        };
    };
  };
}
