{ config, pkgs, ... }: {
  # =============================================================================
  # DESKTOP ENVIRONMENT BASE
  # =============================================================================

  # Keyboard configuration
  console.keyMap = "us";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };
}