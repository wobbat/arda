{
  config,
  lib,
  pkgs,
  ...
}:

let
  mod = "Mod1";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      bars = [
        {
          position = "top";
        }
      ];
      
      fonts = [ "Jetbrains Mono Bold 14" ];
      gaps = {
        inner = 10;
        outer = 5;
      };
      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";

        "${mod}+q" = "kill";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+v" = "split v";
        "${mod}+minus" = "split h";

        "${mod}+f" = "fullscreen toggle";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";
      };
    };
  };
    xsession.windowManager.i3.extraConfig = ''
    default_border pixel 4
    '';
}
