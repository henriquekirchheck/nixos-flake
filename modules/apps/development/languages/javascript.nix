{
  den.aspects.apps.provides.development.provides.languages.provides.javascript.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        deno
        nodejs
        nodePackages.pnpm
        typescript-language-server
        angular-language-server
        svelte-language-server
      ];
    };
}
