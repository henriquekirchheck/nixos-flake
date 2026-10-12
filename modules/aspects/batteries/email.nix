{ __findFile, ... }:
{
  den.aspects.batteries.email =
    {
      name,
      flavor,
      realName,
      address,
      primary ? false,
    }:
    {
      homeManager =
        {
          user,
          config,
          lib,
          ...
        }:
        {
          accounts.email.accounts.${name} = {
            inherit
              primary
              realName
              address
              flavor
              ;
            smtp.tls.useStartTls = true;
            passwordCommand = lib.mkIf (user.hasAspect <sops>) "cat ${
              config.sops.secrets."email/${name}".path
            }";
            thunderbird.enable = user.hasAspect <apps/communication/thunderbird>;
          };
        };
      secretsHome = _: [ "email/${name}" ];
    };
}
