{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = with pkgs; [ virtiofsd ];
      verbatimConfig = ''
                namespaces = []
        	cgroup_device_acl = [
                  "/dev/null", "/dev/full", "/dev/zero",
                  "/dev/random", "/dev/urandom",
                  "/dev/ptmx", "/dev/kvm",
                  "/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset", "/dev/dri/renderD128"
                ]
                seccomp_sandbox = 0
      '';
    };
  };
  programs.virt-manager.enable = true;
  environment.defaultPackages = with pkgs; [ qemu ];
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}
