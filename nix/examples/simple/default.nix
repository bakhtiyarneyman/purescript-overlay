{
  stdenv,
  purix,
}: let
  locked = purix.buildSpagoLock {
    src = ./.;
    lockfile = ./spago.lock;
  };
in
  stdenv.mkDerivation {
    name = "bin";
    src = ./.;
    buildPhase = ''
      echo "Linking ..."
      ln -s ${locked.jsArtifacts.simple}/output .
    '';
    installPhase = ''
      mkdir -p $out
      cp -r output $out
    '';
  }
