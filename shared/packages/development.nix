{ pkgs, ... }:
with pkgs;
[
  git
  nixfmt-rfc-style
  gnumake
  gcc
  pkg-config
  python3
  rustc
  cargo
  cmake
  bun
  nodejs_24
  go
  luaformatter
  vsce
  libpng
]
