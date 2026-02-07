{ den, ... }:
let
  otherDiskName = "other";
in
{
  den.aspects.pc = {
    includes = [
      (den.aspects.utils._.host._.locale {
        default = "en_US.UTF-8";
        extra = "pt_BR.UTF-8";
      })

      (den.aspects.utils._.disk._.createDisk {
        name = otherDiskName;
      })

      den.aspects.apps._.sops

      (den.aspects.hardware._.networking._.systemd._.networkd._.static-config {
        address = "10.0.0.10/24";
        gateway = "10.0.0.1";
      })

      den.aspects.services._.zerotier

      den.aspects.system._.kernel._.cachy._.stable-v3
      den.aspects.system._.oom._.systemd-oomd

      (den.aspects.services._.caddy._.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
        hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
      })
      (den.aspects.services._.caddy._.includeEnvironment ./secrets/caddy.env)
      (den.aspects.services._.caddy._.includeGlobal ''
        acme_dns cloudflare {$CLOUDFLARE_API}
      '')

      den.aspects.services._.cloudflared
      (den.aspects.services._.cloudflared._.addTunnel {
        id = "52ba507f-2e7c-4527-9010-aaa4ff579fa2";
        sopsFile = ./secrets/tunnel-52ba507f-2e7c-4527-9010-aaa4ff579fa2.json;
      })

      (den.aspects.services._.ddclient {
        protocol = "cloudflare";
        domains = [ "henriquekh.dev.br" ];
        zone = "henriquekh.dev.br";
        sopsFile = ./secrets/ddclient.yaml;
      })

      den.aspects.services._.forgejo-runner
      (den.aspects.services._.forgejo-runner._.addInstance {
        name = "henrique-pc";
        url = "https://codeberg.org";
        sopsFile = ./secrets/forgejo-runner.env;
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = otherDiskName;
        subvolume = "forgejo-runner";
        mountpoint = "/var/lib/private/gitea-runner";
      })
    ];
  };
}
