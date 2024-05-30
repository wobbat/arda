{
      programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
    format = ''
$time $directory
$character
'';
    right_format = ''$all'';

      # add_newline = false;

      character = {
        success_symbol = "[|](bold red)[|](bold green)[|](bold yellow)[|](bold purple)[|](bold blue)";
        error_symbol = "[|](bold red)[|](bold red)[|](bold red)[|](bold red)[|](bold red)";
      };

      aws = {
        disabled = true;
      };

      time = {
        disabled = false;
        format = "[$time](white bold)";
        time_format = "%H:%M";
      };
            
      directory = {
        style = "white bold";
      };
      # package.disabled = true;
    };
  };

}