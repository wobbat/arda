{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    go
    yarn
    nodejs_22 
    gnumake
  
  ];
}
