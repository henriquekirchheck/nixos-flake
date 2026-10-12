{ __findFile, ... }:
{
  den.aspects.lina = {
    includes = [
      <den/primary-user>
      (<den/user-shell> "fish")
      (<batteries/xdg-dirs> {
        music = "stuff/music";
        videos = "stuff/videos";
        pictures = "stuff/pictures";
        documents = "stuff/documents";
        templates = "stuff/templates";
        publicShare = "stuff/public";
        desktop = "desktop";
        download = "download";
        projects = "src";
      })

      <sops>
      (<sops/userFile> ./secrets.yaml)
      <batteries/sops-password>

      (<batteries/email> {
        name = "gmail-personal";
        realName = "Henrique Kirch Heck";
        address = "henriquekirchheck@gmail.com";
        flavor = "gmail.com";
        primary = true;
      })
      (<batteries/email> {
        name = "gmail-games";
        realName = "GamesRevolution";
        address = "henrique.gamesrev@gmail.com";
        flavor = "gmail.com";
      })

      <apps/nix/trusted-user>
      <apps/virtualisation/libvirtd/permission>
      <apps/containers/docker/permission>
      <services/sshd/allow-user>
      <hardware/networking/network-manager/permission>
      <hardware/printer/permission>
      <hardware/scanner/permission>

      <hardware/tablet>

      <apps/comma>
      <apps/cli>
      <apps/ssh>

      <apps/window-managers/niri>
      <apps/desktop-shells/noctalia>

      <apps/sh/shells/bash>
      <apps/sh/shells/fish>
      <apps/sh/utils/fzf>
      <apps/sh/utils/direnv>
      <apps/sh/utils/zoxide>
      <apps/sh/utils/starship>
      <apps/sh/utils/aliases>

      <apps/development/vcs/git>
      <apps/development/vcs/jujutsu>

      # <apps/development/editors/emacs>
      <apps/development/editors/neovim>
      <apps/development/editors/zed>

      <apps/development/languages/ansible>
      <apps/development/languages/c-cpp>
      <apps/development/languages/docker>
      <apps/development/languages/godot>
      <apps/development/languages/java>
      <apps/development/languages/javascript>
      <apps/development/languages/lua>
      <apps/development/languages/markdown>
      <apps/development/languages/nix>
      <apps/development/languages/python>
      <apps/development/languages/rust>
      <apps/development/languages/shaders>
      <apps/development/languages/shell>
      <apps/development/languages/tex>
      <apps/development/languages/tofu>
      <apps/development/languages/typst>
      <apps/development/languages/web>

      <apps/media/ffmpeg>
      <apps/media/mpv>
      <apps/media/models/blender>
      <apps/media/videos/gpu-screen-recorder>
      <apps/media/videos/obs>
      <apps/media/videos/yt-dlp>
      <apps/media/subtitles/aegisub>
      <apps/media/images/krita>
      <apps/media/images/gimp>
      <apps/media/audio/fin>
      <apps/media/audio/sone>

      <apps/fetch/fastfetch>
      <apps/fetch/hyfetch>
      <apps/fetch/onefetch>

      <apps/compatibility/wine>

      <apps/games/steam>
      <apps/games/gamemode>
      <apps/games/gamescope>
      <apps/games/mangohud>
      <apps/games/r2modman>
      <apps/games/archipelago>
      <apps/games/minecraft/launchers/prismlauncher>

      <apps/documents/zathura>
      <apps/documents/libreoffice>

      <apps/communication/discord>
      <apps/communication/element>
      <apps/communication/thunderbird>

      <apps/web/aria2>
      <apps/web/zen>

      <apps/terminal-emulators/alacritty>

      <apps/security/keyrings/kwallet>
    ];

    user = {
      description = "Lina Lilith";
      openssh.authorizedKeys.keys = [ ];
    };
  };
}
