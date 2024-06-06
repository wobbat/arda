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


      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;


  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
