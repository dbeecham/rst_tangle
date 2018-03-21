let pkgs = import <nixpkgs> {}; in
pkgs.stdenv.mkDerivation {
    name = "rst_tangle";
    nativeBuildInputs = with pkgs; [ ragel ];
}
