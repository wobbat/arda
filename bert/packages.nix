{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    environment.systemPackages = with pkgs; [
        vscode
        inputs.helix.packages."${pkgs.system}".helix
        git
        firefox
  ];
}