{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive
          # Commands to run in interactive sessions can go here
      end

      set fish_color_error normal
      set fish_color_command green
      set fish_greeting

      set FLAKE /home/wobbat/wobbix


      switch (uname)
      case Linux
          #echo Hi Tux!
          fish_add_path $HOME/.cargo/bin
      case Darwin
          eval (/opt/homebrew/bin/brew shellenv)
          fish_add_path $HOME/go/bin
      case FreeBSD NetBSD DragonFly
          #echo Hi Beastie!
      case '*'
          #echo Hi, stranger!
      end

      alias cl="clear"

      #ls replacement with exa
      alias la="eza -a --group-directories-first"
      alias lal="eza -la --group-directories-first"
      alias lsl="eza -l --group-directories-first"
      alias ls="eza --group-directories-first"
      alias nos="sudo nixos-rebuild switch --flake /home/wobbat/wobbix"
      alias wob=" sudo nixos-rebuild switch --flake /home/wobbat/wobbix &| nom"
      alias g3="gnome-shell --wayland"
      alias hl="hyperland"
      alias frun="fuzzel -I -b 151515ff -f 'Inconsolata bold: size=24' -B0 -x1000 -y1000"
      alias hldm="hyprctl keyword monitor eDP-1, disable"
      alias hlsl="hyprctl keyword monitor 'eDP-1,2880x1800@90,0x0,1.6'"

      starship init fish | source
    '';
  };
}
