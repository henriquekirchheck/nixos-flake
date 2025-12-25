{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) types;
  cfg = config.programs.mpris-scrobbler;

  # validServices = [
  #   "listenbrainz"
  #   "librefm"
  #   "lastfm"
  # ];

  # writePerService =
  #   f:
  #   lib.strings.concatLines (
  #     map (
  #       service: if lib.attrsets.hasAttrByPath [ service ] cfg.credentials then f service else ""
  #     ) validServices
  #   );

  # credentialsFile' = pkgs.writeText "credentials" ''
  #   ${writePerService (
  #     service:
  #     let
  #       credentials = cfg.credentials.${service};
  #     in
  #     ''
  #       [${service}]
  #       enabled = ${if (credentials.enable) then "true" else "false"}
  #       username = ${credentials.username}
  #       token = @${service}_token_placeholder@
  #       session = @${service}_session_placeholder@
  #     ''
  #   )}
  # '';
  # credentialsFilePath = "${config.xdg.dataHome}/mpris-scrobbler/credentials";

  # preStart = ''
  #   install --mode=600 --owner=$USER "${credentialsFile'}" "${credentialsFilePath}"
  #   ${writePerService (
  #     service:
  #     let
  #       credentials = cfg.credentials.${service};
  #     in
  #     ''
  #       "${pkgs.replace-secret}/bin/replace-secret" "@${service}_token_placeholder@" "${credentials.tokenFile}" "${credentialsFilePath}"
  #       "${pkgs.replace-secret}/bin/replace-secret" "@${service}_session_placeholder@" "${credentials.sessionFile}" "${credentialsFilePath}"
  #     ''
  #   )}
  # '';
  # postStop = ''rm -f "${credentialsFilePath}"'';
in
{
  options.programs.mpris-scrobbler = {
    enable = lib.mkEnableOption "mpris-scrobbler";
    package = lib.mkPackageOption pkgs "mpris-scrobbler" { };
    verbosity = lib.mkOption {
      default = "v";
      description = "specify a verbosity level or null for no logs";
      type = types.nullOr (
        types.enum [
          "v"
          "vv"
          "vvv"
        ]
      );
    };
    # credentials = lib.mkOption {
    #   default = { };
    #   example = lib.literalExpression ''
    #     {
    #       listenbrainz = {
    #         username = "example_user";
    #         tokenFile = <file_path>;
    #         sessionFile = <file_path>;
    #       };
    #       librefm = {
    #         username = "example_user";
    #         tokenFile = <file_path>;
    #         sessionFile = <file_path>;
    #       };
    #       lastfm = {
    #         username = "example_user";
    #         tokenFile = <file_path>;
    #         sessionFile = <file_path>;
    #       };
    #     }
    #   '';
    #   description = "Configure the scrobbling services";
    #   type = types.attrsOf (
    #     types.submodule (
    #       { ... }:
    #       {
    #         options = {
    #           enable = lib.mkEnableOption "service for mpris-scrobbler" // {
    #             default = true;
    #             example = lib.literalExpression "false";
    #           };
    #           username = lib.mkOption {
    #             type = types.nonEmptyStr;
    #             description = "scrobbler service username";
    #             example = "user-example";
    #           };
    #           tokenFile = lib.mkOption {
    #             type = types.externalPath;
    #             description = "a file path to your token value";
    #           };
    #           sessionFile = lib.mkOption {
    #             type = types.externalPath;
    #             description = "a file path to your session value";
    #           };
    #         };
    #       }
    #     )
    #   );
    # };
  };

  config = lib.mkIf cfg.enable {
    # assertions = [
    #   {
    #     assertion = (lib.lists.subtractLists validServices (lib.attrsets.attrNames cfg.credentials)) == [ ];
    #     message = "programs.mpris-scrobbler.credentials.<name> may only be: listenbrainz, librefm, lastfm";
    #   }
    # ];

    home.packages = [ cfg.package ];

    systemd.user.services.mpris-scrobbler = {
      Install.WantedBy = [ "multi-user.target" ];
      Unit = {
        Description = "mpris-scrobbler AutoScrobbler";
        After = [ "dbus.service" ];
      };
      Service = {
        # ExecStartPre = "${pkgs.writeShellScript "mpris-scrobbler-prestart" preStart}";
        ExecStart = "${lib.getExe cfg.package} ${
          if cfg.verbosity != null then "-${cfg.verbosity}" else ""
        }";
        # ExecStopPost = "${pkgs.writeShellScript "mpris-scrobbler-poststop" postStop}";
      };
    };
  };
}
