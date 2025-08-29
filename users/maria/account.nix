{ pkgs, ... }:
{
  users.users.maria = {
    isNormalUser = true;
    description = "Maria Cecilia Kirch";
    extraGroups = [
      "networkmanager"
    ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };
}
