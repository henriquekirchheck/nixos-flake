{
  den.aspects.apps.development.languages.lua = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        lua
        lua-language-server
      ];
    };
    zed-extensions = _: [ "lua" ];
  };
}
