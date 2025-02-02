{ ... }:

{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
  services.open-webui = {
    enable = true;
    port = 11111;
    openFirewall = true;
  };
}
