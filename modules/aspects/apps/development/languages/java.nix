{
  den.aspects.apps.development.languages.java = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        openjdk25
        lombok
        jdt-language-server
      ];
    };

    zed-extensions = _: [ "java" ];
    zed-settings = { pkgs, ... }: {
      lsp.jdtls.settings = {
        lombok_support = true;
        jdk_auto_download = false;
        check_updates = "never";
        lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
      };
    };
  };
}
