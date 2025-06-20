{pkgs, inputs, ...}:
with pkgs; [
  firefox
  google-chrome
  vivaldi
  ladybird
  inputs.zen-browser.packages.${pkgs.system}.default
]
