{ config, pkgs, inputs, ...}: {
    environment.systemPackages = with pkgs; [
        vscode
        inputs.helix.packages."${pkgs.system}".helix
        git
        firefox
        wget
        python3
  ];
}