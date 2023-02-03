{ pkgs ? import <nixpkgs> { } }:
with pkgs; stdenv.mkDerivation {
  name = "pages";
  src = ./.;

  nativeBuildInputs = [
    asciidoctor
  ];

  buildPhase = ''
    asciidoctor --attribute reproducible="true" README.adoc -o index.html
  '';

  installPhase = ''
    mkdir -p $out
    cp index.html $out
    cp screenshot.webp $out
  '';
}

