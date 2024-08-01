{
  fetchzip ? (import <nixpkgs> {}).fetchzip,
  nixpkgs ? import (fetchzip {
    url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/refs/tags/24.05";
    hash = "sha256-vboIEwIQojofItm2xGCdZCzW96U85l9nDW3ifMuAIdM=";
  }) {},
}:
let
  inherit (nixpkgs) lua51Packages;
  nvim-wrapped-script =
    ''
    mkdir -p $out/bin
    mkdir -p $out/share/nvim/lua/
    ln -s ${./lua/histon} $out/share/nvim/lua/histon
    ln -s ${lua51Packages.telescope-nvim}/share/lua/5.1/telescope $out/share/nvim/lua/
    ln -s ${lua51Packages.plenary-nvim}/share/lua/5.1/plenary $out/share/nvim/lua/
    makeWrapper ${nixpkgs.neovim}/bin/nvim $out/bin/nvim --add-flags "-u ${./dev/init.lua}" --set XDG_CONFIG_HOME $out/share/
    '';
  nvim-wrapped =
    with nixpkgs; nixpkgs.runCommand "nvim-wrapped"
    {
      buildInputs = [
        neovim
        makeWrapper
        lua51Packages.telescope-nvim
        lua51Packages.plenary-nvim
      ];
    }
    nvim-wrapped-script;
in
nixpkgs.mkShellNoCC {
    name = "telescope-histon-dev-shell";
    packages = [
      nvim-wrapped
    ];
}
