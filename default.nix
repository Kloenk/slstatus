{ 
  system ? builtins.currentSystem
  ,pkgs ? import <nixpkgs> { inherit system; }
  ,libX11 ? pkgs.xorg.libX11
  , ...
}:

with pkgs;
stdenv.mkDerivation {
  name = "slstatus-0.1";
  src = ./.;
  buildInputs = [ libX11 ];

  prePatch = ''
    sed -i "s@/usr/local@$out@" config.mk
  '';

  buildPhase = " make ";

  meta = {
    homepage = https://github.com/kloenk/slstatus;
    description = "status bar";
    license = stdenv.lib.licenses.mit;
    # TODO add maintainer
    platforms = with stdenv.lib.platforms; all;
  };
}
