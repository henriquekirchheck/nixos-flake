{ __findFile, ... }:
{
  den.aspects.apps.media.mpv = {
    includes = [ <apps/media/ffmpeg> ];
    homeManager =
      {
        osConfig,
        lib,
        pkgs,
        ...
      }:
      let
        mkMpv =
          pkgs:
          pkgs.mpv.override {
            scripts = with pkgs.mpvScripts; [
              mpris
              thumbfast
              quality-menu
              bdanmaku
              uosc
              sponsorblock

              mpv-image-viewer.detect-image
              mpv-image-viewer.image-positioning
              mpv-image-viewer.freeze-window
              mpv-image-viewer.status-line
              mpv-image-viewer.minimap
              mpv-image-viewer.ruler
            ];
          };
      in
      {
        programs.mpv = {
          enable = true;
          package = lib.mkMerge [
            (lib.mkIf (!osConfig.hardware.nvidia.enabled) (mkMpv pkgs))
            (lib.mkIf (osConfig.hardware.nvidia.enabled) (mkMpv pkgs.pkgsCuda))
          ];
          config = {
            vo = "gpu-next";
            hwdec = "auto-safe";
            profile = "gpu-hq";
            ytdl-format = "bestvideo+bestaudio";
          };
          bindings = {
            # Mouse bindinds
            MBTN_RIGHT = "script-binding drag-to-pan";
            MBTN_LEFT = "script-binding pan-follows-cursor";
            MBTN_LEFT_DBL = "ignore";
            WHEEL_UP = "script-message cursor-centric-zoom 0.1";
            WHEEL_DOWN = "script-message cursor-centric-zoom -0.1";

            # Keyboard bindings
            ## Pan Image
            "ctrl+down" = "repeatable script-message pan-image y -0.1 yes yes";
            "ctrl+up" = "repeatable script-message pan-image y +0.1 yes yes";
            "ctrl+right" = "repeatable script-message pan-image x -0.1 yes yes";
            "ctrl+left" = "repeatable script-message pan-image x +0.1 yes yes";
            "alt+down" = "repeatable script-message pan-image y -0.01 yes yes";
            "alt+up" = "repeatable script-message pan-image y +0.01 yes yes";
            "alt+right" = "repeatable script-message pan-image x -0.01 yes yes";
            "alt+left" = "repeatable script-message pan-image x +0.01 yes yes";
            ## Reset Image
            "ctrl+0" = "no-osd set video-pan-x 0; no-osd set video-pan-y 0; no-osd set video-zoom 0";
            ## Zoom
            "+" = "add video-zoom 0.5";
            "-" = "add video-zoom -0.5; script-message reset-pan-if-visible";
            "=" = "no-osd set video-zoom 0; script-message reset-pan-if-visible";
            ## Flip
            "h" = ''no-osd vf toggle hflip; show-text "Horizontal flip"'';
            "v" = ''no-osd vf toggle vflip; show-text "Vertical flip"'';
            ## Rotate
            "r" = ''script-message rotate-video 90; show-text "Clockwise rotation"'';
            "R" = ''script-message rotate-video -90; show-text "Counter-clockwise rotation"'';
            "alt+r" = ''no-osd set video-rotate 0; show-text "Reset rotation"'';
            ## Ruler
            "d" = "script-message ruler";
            ## Filtering
            "a" = "cycle-values scale nearest ewa_lanczossharp";
            ## Aspect ratio info
            "A" = ''cycle-values video-aspect-override "-1" "no"'';
            ## Print filename
            "p" = "script-message force-print-filename";
          };
        };
      };
  };
}
