{
  pkgs,
  inputs,
  ...
}:
with pkgs; [
  vscode
  inputs.helix.packages."${pkgs.system}".helix
  neovim
]
