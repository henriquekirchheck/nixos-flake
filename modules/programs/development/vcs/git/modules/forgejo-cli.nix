{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.programs.forgejo-cli;

  config' = pkgs.writeText "keys.json" (
    builtins.toJSON {
      inherit (cfg) aliases;
      default_ssh = cfg.defaultSSH;
      hosts = builtins.mapAttrs (name: value: {
        type = "Application";
        inherit (value) name;
        token = "@${name}_token_placeholder@";
      }) cfg.hosts;
    }
  );

  dataDir = "${config.xdg.dataHome}/forgejo-cli";
  keysFile = "${dataDir}/keys.json";

  preStart = ''
    mkdir -p "${dataDir}"
    install --mode=600 --owner=$USER ${config'} "${keysFile}"
    ${lib.strings.concatLines (
      map (
        { name, value }:
        ''"${lib.getExe pkgs.replace-secret}" "@${name}_token_placeholder@" "${value.tokenFile}" "${keysFile}"''
      ) (lib.attrsToList cfg.hosts)
    )}
  '';
  start = ''"${lib.getExe' pkgs.coreutils "sleep"}" infinity'';
  postStop = ''"${lib.getExe' pkgs.coreutils "rm"}" -rf "${dataDir}"'';
in
{
  options.programs.forgejo-cli = {
    enable = lib.mkEnableOption "forgejo-cli";
    package = lib.mkPackageOption pkgs "forgejo-cli" { };
    hosts = lib.mkOption {
      description = "Hosts to authenticate to. (only application access tokens supported)";
      default = { };
      example = lib.literalExpression ''
        {
          "codeberg.org" = {
            name = <username>;
            tokenFile = <file_path>;
          };
        }
      '';
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            enable = lib.mkEnableOption "forgejo-host" // {
              description = ''
                Whether to include this host in final config file, enabled by default.

                Useful if you want to define all hosts in a single place and change it per configuration
              '';
              default = true;
              example = lib.literalExpression "false";
            };
            name = lib.mkOption {
              type = lib.types.str;
              description = "Username of the account in the host";
              example = "<username>";
            };
            tokenFile = lib.mkOption {
              type = lib.types.either lib.types.path lib.types.str;
              description = "Application access tokens to the host";
              example = lib.literalExpression "config.sops.secrets.token.path";
            };
          };
        }
      );
    };
    aliases = lib.mkOption {
      description = "Aliases";
      default = { };
      type = lib.types.attrsOf lib.types.str;
    };
    defaultSSH = lib.mkOption {
      description = "Hosts where ssh will be used by default with git operations";
      default = [ ];
      example = lib.literalExpression ''
        [
          "codeberg.org"
          "code.forgejo.org"
        ]
      '';
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    systemd.user.services.forgejo-cli-credentials = {
      Install.WantedBy = [ "multi-user.target" ];
      Unit.Description = "forgejo-cli credentials";

      Service = {
        ExecStartPre = ''${pkgs.writeShellScript "forgejo-cli-credentials-prestart" preStart}'';
        ExecStart = ''${pkgs.writeShellScript "forgejo-cli-credentials-start" start}'';
        ExecStopPost = ''${pkgs.writeShellScript "forgejo-cli-credentials-poststop" postStop}'';
      };
    };
  };
}
