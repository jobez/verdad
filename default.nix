let
  pkgs = import /home/jmsb/exps/nixpkgs {};
  stdenv = pkgs.stdenv;
in
stdenv.mkDerivation {
  name = "libigl-ecl";
  # outputs = [ "out" "dev" "bin" "lib"];
  buildInputs = [
    pkgs.git
    pkgs.cmake
    pkgs.openblas
    pkgs.freeglut
    pkgs.mesa
    pkgs.xorg.libXi
    pkgs.xorg.libXfixes
    pkgs.xorg.libXfixes.dev
    pkgs.xorg.libX11
    pkgs.xorg.libXext.dev
    pkgs.xorg.libXrandr
    pkgs.xorg.libXrandr.dev
    pkgs.xorg.libXinerama
    pkgs.xorg.libXcursor
    pkgs.xorg.xinput
    pkgs.glfw
    pkgs.ecl
  ];


  LIBIGL_DIR=/home/jmsb/exps/langs/c++/graphics/libigl;
  # cmakeFlags = ["-D"
# ];
  installFlags = [ "INSTALL_ROOT=$(out)" ];
  src = ./.;
  shellHook = "
export CPATH=$CPATH:/home/jmsb/exps/langs/c++/graphics/libigl/include
export PATH=$PATH:/home/jmsb/exps/langs/lisp/common/compilec/c-mera
";
}
