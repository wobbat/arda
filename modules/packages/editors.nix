{
  pkgs,
  inputs,
  ...
}:
with pkgs; [
  vscode
  inputs.helix.packages."${pkgs.system}".helix
  # put this here because in browser everything broke...
  inputs.zen-browser.packages.${pkgs.system}.default
]
