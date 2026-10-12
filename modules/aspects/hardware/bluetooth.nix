{
  den.aspects.hardware.bluetooth = {
    nixos.hardware.bluetooth.enable = true;
    persist = _: { directories = [ "/var/lib/bluetooth" ]; };
  };
}
