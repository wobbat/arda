{pkgs, ...}: {
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "dim.nvim";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "wobbat";
        repo = "dim.nvim";
        rev = "4243de804ee3d57fcae62c258a275300fa4b65fd";
        hash = "sha256-VQbhdbDf8POB6+sR4Ys/k7suF8vQvXnFmeyJk6Zyc/o=";
      };
    })
  ];
}