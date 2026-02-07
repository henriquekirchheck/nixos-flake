{
  den.aspects.services.provides.zerotier = {
    description = "Zerotier VPN";

    nixos.services.zerotierone.enable = true;

    provides.auto-join = id: {
      description = "Add network to auto-join list";
      nixos.services.zerotierone.joinNetworks = [ id ];
    };
  };
}
