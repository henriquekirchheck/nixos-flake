{
  den.aspects.services.provides.aster-bridge = sopsFile: {
    description = "Aster Bridge";
    homeManager = { pkgs, ... }: {
      # TODO: Setup aster-bridge
    };
  };

  perSystem = { pkgs, ... }: {
    packages.aster-bridge = pkgs.callPackage (
      {
        lib,
        fetchFromGitHub,
        rustPlatform,

        pkg-config,
        perl,
        glib,
        webkitgtk_4_1,
        libayatana-appindicator,
        librsvg,
        xdo,
      }:
      rustPlatform.buildRustPackage (final: {
        pname = "aster-bridge";
        version = "0.4.38";

        src = fetchFromGitHub {
          owner = "Aster-Privacy";
          repo = "Aster-Bridge";
          tag = "v${final.version}";
          hash = "sha256-CrY7jcYhKqbDqwK/oBY1VebUZNKyc5th7qN41u6kY90=";
        };
        cargoHash = "sha256-r0cKPd2NHQ0r+3pyk5NK9lIGem9y0C8XnH7DjI3seR8=";

        cryptoSrc = fetchFromGitHub {
          owner = "Aster-Privacy";
          repo = "Aster-Mail";
          tag = "v1.4.68";
          hash = "sha256-+yylP9EOYphlbR/S8nXL+CKqS/MF3fDEf5GY+R64Kpk=";
        };

        nativeBuildInputs = [
          perl
          pkg-config
          glib.dev
          webkitgtk_4_1
          libayatana-appindicator
          librsvg
          xdo
        ];

        cargoRoot = "src-tauri";
        buildAndTestSubdir = "src-tauri";

        cargoBuildFlags = [
          "--locked"
          "-p"
          "aster-bridge-cli"
        ];

        patchPhase = ''
          substituteInPlace src-tauri/crates/aster_bridge_core/Cargo.toml \
            --replace-fail "../../../../Aster-Mail" "$cryptoSrc"
        '';

        meta = {
          description = "Desktop bridge that connects IMAP, POP, and SMTP mail clients to Aster Mail";
          homepage = "https://github.com/Aster-Privacy/Aster-Bridge";
          license = lib.licenses.agpl3Only;
        };
      })
    ) { };
  };
}
