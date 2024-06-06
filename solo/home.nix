{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [

  ];


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    rxvt-unicode
    vscode
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
