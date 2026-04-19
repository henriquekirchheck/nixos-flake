{
  den.hosts.x86_64-linux.pc = {
    hostName = "henrique-pc";
    description = "Personal Computer that I also use as a server";
    users.henrique.classes = [ "homeManager" ];
  };
  den.hosts.x86_64-linux.laptop = {
    hostName = "henrique-laptop";
    description = "Laptop that I use occasionally";
    users = {
      henrique.classes = [ "homeManager" ];
      maria.classes = [ "homeManager" ];
    };
  };
}
