{
  stdenv,
  meson,
  ninja,
  pkg-config,
  cmake,
  aubio,
  pipewire,
}:

stdenv.mkDerivation {
  pname = "beat-detector";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    meson
    ninja
    cmake
    pkg-config
    pipewire.dev
  ];

  buildInputs = [
    aubio
    pipewire
  ];
}
