{ __findFile, den, ... }:
{
  den.aspects.maria = {
    includes = [
      (<batteries/xdg-dirs> {
        music = "Músicas";
        videos = "Vídeos";
        pictures = "Imagens";
        documents = "Documentos";
        templates = "Modelos";
        desktop = "Área de trabalho";
        download = "Download";
        projects = "Projetos";
        publicShare = "Público";
      })

      <hardware/networking/network-manager/permission>
      <hardware/printer/permission>
      <hardware/scanner/permission>

      (den.lib.policy.when ({ host, ... }: host.hasAspect <stylix.module>) <stylix/disable>)

      <apps/comma>

      <apps/window-managers/plasma>

      <apps/media/ffmpeg>
      <apps/media/mpv>
      <apps/media/images/krita>
      <apps/media/images/gimp>
      <apps/documents/libreoffice>

      <apps/compatibility/wine>

      <apps/terminal-emulators/alacritty>

      <apps/security/keyrings/kwallet>
    ];

    user = {
      description = "Maria Cecilia Kirch";
      initialPassword = "password";
    };
  };
}
