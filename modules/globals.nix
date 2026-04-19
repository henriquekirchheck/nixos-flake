{ den, ... }:
{
  den.default = {
    includes = [ den.provides.hostname ];
    nixos = {
      system.stateVersion = "26.05";
      time.timeZone = "America/Sao_Paulo";
      console.keyMap = "br-abnt2";
    };
    homeManager.home.stateVersion = "26.05";
  };
}
