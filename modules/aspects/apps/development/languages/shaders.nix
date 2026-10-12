{
  den.aspects.apps.development.languages.shaders = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        wgsl-analyzer
        shader-slang
        glsl_analyzer
      ];
    };
    zed-extensions = _: [
      "wgsl-wesl"
      "slang"
      "hlsl"
      "glsl"
    ];
  };
}
