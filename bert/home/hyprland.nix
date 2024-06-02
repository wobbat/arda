{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 6;
        "col.inactive_border" = "0xff202020";
        "col.active_border" = "0xff7a3a2b";
      };
      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      decoration = {
        rounding = 0;
      };

      animations = {
        enabled = true;
      };

      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };

        # kb_options = "ctrl:nocaps";
      };
      windowrulev2 = [
        "noborder, onworkspace:w[t1]"
        # # only allow shadows for floating windows
        # "noshadow, floating:0"

        # # idle inhibit while watching videos
        # "idleinhibit focus, class:^(mpv|.+exe)$"
        # "idleinhibit fullscreen, class:.*"

        # # make Firefox PiP window floating and sticky
        # "float, title:^(Picture-in-Picture)$"
        # "pin, title:^(Picture-in-Picture)$"

        # "float, class:^(1Password)$"
        # "stayfocused,title:^(Quick Access — 1Password)$"
        # "dimaround,title:^(Quick Access — 1Password)$"
        # "noanim,title:^(Quick Access — 1Password)$"

        # "float, class:^(org.gnome.*)$"
        # "float, class:^(pavucontrol)$"
        # "float, class:(blueberry\.py)"

        # # make pop-up file dialogs floating, centred, and pinned
        # "float, title:(Open|Progress|Save File)"
        # "center, title:(Open|Progress|Save File)"
        # "pin, title:(Open|Progress|Save File)"
        # "float, class:^(code)$"
        # "center, class:^(code)$"
        # "pin, class:^(code)$"

        # # assign windows to workspaces
        "workspace 5 silent, class:[Ff]irefox"
        # "workspace 2 silent, class:[Oo]bsidian"
        # "workspace 2 silent, class:google-chrome"
        # "workspace 2 silent, class:[Rr]ambox"
        # "workspace 1 silent, class:[Ss]ignal"
        # "workspace 5 silent, class:code-url-handler"

        # # throw sharing indicators away
        # "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        # "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, return, exec, alacritty"
        "$mod, d, exec, fuzzel"

        "$mod, q, killactive"

        "$mod, M, exit"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    colors.background = "151515ff";
    colors.text = "b4b4b4ff";
    colors.selection = "202020ff";
    colors.selection-text = "896a40ff";
    colors.selection-match = "7a3a2bff";
    colors.match = "7a3a2bff";
    main.font = "Inconsolata bold: size=24";
    main.icons-enabled = "no";
    main.horizontal-pad = 1000;
    main.vertical-pad = 1000;
    border.width = 0;
  };
}
