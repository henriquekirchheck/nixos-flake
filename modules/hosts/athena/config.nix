{ __findFile, ... }:
{
  den.hosts.x86_64-linux.athena = {
    hostName = "athena";
    description = "Shared family laptop";

    users = {
      lina.classes = [ "homeManager" ];
      maria.classes = [ "homeManager" ];
    };

    settings = {
      disk.btrfs.device = "";
      batteries = {
        locale = {
          default = "pt_BR.UTF-8";
          extra = "pt_BR.UTF-8";
        };
        peripheral = {
          outputs = {
            # TODO: Change to actual monitor configs
            DVI-D-1 = {
              position = {
                x = 0;
                y = 0;
              };
              mode = {
                width = 0;
                height = 0;
              };
            };
          };
          xkb = {
            layout = "br";
            model = "abnt2";
            options = "caps:escape_shifted_capslock";
          };
        };
      };
    };
  };

  den.aspects.athena = {
    includes = [
      <disk/btrfs>

      <sops>

      <themes/catppuccin>

      <hardware/kernel/xanmod>
      <hardware/bootloader/systemd-boot>
      <hardware/graphics/amd>
      <hardware/graphics/intel>
      <hardware/swap/zswap>
      <hardware/audio/pipewire>
      <hardware/networking/network-manager>

      <apps/nix>

      <apps/containers/podman>
      <apps/compatibility/wine>

      <apps/security/fail2ban>
      <apps/security/firewall>
      <apps/security/permission/sudo-rs>

      <apps/display-managers/cosmic-greeter>

      <services/sshd>
      <services/zerotier>
    ];
  };
}
