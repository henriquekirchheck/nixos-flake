{
  den.default = {
    nixos = {
      system.stateVersion = "25.05";
      time.timeZone = "America/Sao_Paulo";
      console.keyMap = "br-abnt2";
    };
    homeManager.home.stateVersion = "25.05";
  };
}
