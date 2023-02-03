{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        name = "pages";
        packages.pages = import ./default.nix { pkgs = pkgs; };
        packages.default = packages.pages;
        apps.default = flake-utils.lib.mkApp
          {
            drv = pkgs.writeShellScriptBin "pages" "${pkgs.python3}/bin/python3 -m http.server 8000 -d ${packages.pages}";
          };

      }
    );
}
