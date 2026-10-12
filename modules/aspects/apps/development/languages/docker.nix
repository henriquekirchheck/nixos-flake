{
  den.aspects.apps.development.languages.docker = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.dockerfile-language-server
        pkgs.docker-compose-language-service
      ];
    };
    zed-extensions = _: [
      "dockerfile"
      "docker-compose"
    ];
    zed-settings = _: [
      {
        file_types.Dockerfile = [ "Dockerfile.*" ];
      }
    ];
  };
}
