with import <nixpkgs> {};

let

  conduit_async = ocamlPackages.buildDunePackage rec {
    pname = "conduit-async";
    inherit (conduit_local) version src meta;
    propagatedBuildInputs = with ocamlPackages; [ conduit_local async async_ssl async_extra ];
  };

  conduit_local = ocamlPackages.buildDunePackage rec {
    pname = "conduit";
      version = "1.2.0";

      src = fetchFromGitHub {
          owner = "mirage";
          repo = "ocaml-conduit";
          rev = "v${version}";
          sha256 = "02j6vxa4zlj4li6di37zphgy5y475g0xl18k92xxglqqpivpkwpp";
      };

      buildInputs = with ocamlPackages; [ ppx_sexp_conv ];
      propagatedBuildInputs = with ocamlPackages; [ astring ipaddr uri ];

      meta = {
          description = "Network connection library for TCP and SSL";
          license = stdenv.lib.licenses.isc;
          maintainers = [ stdenv.lib.maintainers.vbgl ];
          inherit (src.meta) homepage;
      };
  };

  cohttp_async = ocamlPackages.buildDunePackage rec {
    pname = "cohttp-async";
    inherit (ocamlPackages.cohttp) version src meta;

    propagatedBuildInputs = with ocamlPackages; [ cohttp logs base fmt uri ppx_sexp_conv ipaddr async_unix async_kernel conduit_async magic-mime ];

  };

  dune = stdenv.mkDerivation rec {
    name = "dune-${version}";
    version = "1.8.2";
    src = fetchurl {
      url = "https://github.com/ocaml/dune/releases/download/${version}/dune-${version}.tbz";
      sha256 = "1lbgnmzdgb3cp2k2wfhhm5zwlm6dbipab49lh308y2qmh1q6yk6a";
    };

    buildInputs = [ ocaml ocamlPackages.findlib ];

    buildFlags = "release";

    dontAddPrefix = true;

    installPhase = ''
      runHook preInstall
      ${opaline}/bin/opaline -prefix $out -libdir $OCAMLFIND_DESTDIR
      runHook postInstall
    '';

    meta = {
      homepage = https://github.com/ocaml/dune;
      description = "A composable build system";
      maintainers = [ stdenv.lib.maintainers.vbgl ];
      license = stdenv.lib.licenses.mit;
      inherit (ocaml.meta) platforms;
    };
  };
in
mkShell {
  buildInputs = [
    ocaml
    dune
    cohttp_async
  ] ++ (with ocamlPackages; [
    findlib
    utop
    core
    merlin
    async
    yojson
    core_extended
    core_bench
    cohttp
    cryptokit
    menhir
  ]);
}
