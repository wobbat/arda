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
set GOPATH $HOME/go
set MOZ_ENABLE_WAYLAND 1
set OZONE_PLATFORM wayland


set -Ux EDITOR nvim

switch (uname)
case Linux
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/go/bin
case Darwin
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path $HOME/go/bin
case '*'
    #echo Hi, stranger!
end

alias spc="aspell -no-backup -c"
alias cl="clear"
alias bt="bluetui"
alias gofmt="goimports"
#alias xt3='exiftool -Model="RICOH GR III" -UniqueCameraModel="RICOH GR III" -T -ext dng .'
#alias 3tx='exiftool -Model="RICOH GR IIIx" -UniqueCameraModel="RICOH GR IIIx" -T -ext dng .'
alias vim="nvim"
alias n="nvim"
alias backlight="sudo light -s sysfs/backlight/intel_backlight -S"
alias sbm='cat ~/_/bookmarks/bookmarks.txt | fzf --border=rounded --prompt="Search Bookmarks > "  --bind="enter:execute-silent(xdg-open {-1})+abort" --preview="echo {-1}"  --preview-window="up,1" --color=16 --layout=reverse'

function abm
    printf "%s - %s\n" \
        (gum input --placeholder 'Enter the bookmark description' --cursor.foreground '#7e4a3e' --prompt '> ' --width 80) \
        (gum input --placeholder 'Enter the bookmark URL' --cursor.foreground '#7e4a3e' --prompt '> ' --width 80) >> ~/_/bookmarks/bookmarks.txt
end



function nv
    if test (count $argv) -eq 0
        # No arguments, open the current directory (.) in Neovim
        nvim .
    else
        # Arguments provided, open the given file or directory in Neovim
        nvim $argv
    end
end

function tdy
    # Get the current date components
    set current_year (date "+%Y")
    set current_date (date "+%d-%m-%Y")
    set journal_dir "$HOME/_/journal/$current_year"
    set file_name "$journal_dir/$current_date.md"

    # Ensure the journal directory for the current year exists
    if not test -d $journal_dir
        echo "Creating directory: $journal_dir"
        mkdir -p $journal_dir
    end

    if test -e $file_name
    else
        echo "File does not exist. Creating: $file_name"
        touch $file_name
    end

    # Open the file with Neovim
    nvim $file_name
end




#ls replacement with exa
alias la="eza -a --group-directories-first"
alias lal="eza -la --group-directories-first"
alias lsl="eza -l --group-directories-first"
alias ls="eza --group-directories-first"
#alias tm="tmux ls && read tmux_session && tmux attach -t ${tmux_session:-default} || tmux new -s ${tmux_session:-default}"
alias tm="tmux new -As0"
alias tmc="tmux new -Ascode"
alias nos="sudo nixos-rebuild switch --flake /home/wobbat/wobbix"

starship init fish | source
zoxide init fish | source
fish_vi_key_bindings

if test (basename (tty)) = "tty2"
    if not pgrep Xorg > /dev/null
        echo "Starting X server on TTY1..."
        exec startx
    else
        echo "X server is already running."
    end
end

function lg
  fzf --phony \
    --bind "change:reload(rg --vimgrep {q} | cut -d: -f1,2 | uniq || true)" \
    --delimiter=':' \
    --preview 'bash -c "bat --wrap auto --terminal-width 90 --color=always \"\$1\" --highlight-line \"\$2\" --line-range \$(( \$2 > 3 ? \$2 - 3 : 1 )): --theme=ansi 2>/dev/null || echo \"Nothing found (yet)\"" bash {1} {2} 2>/dev/null' \
    --preview-window='right,80%' \
    --height 90% \
    --border=rounded \
    --prompt="find :: " \
    --color=16 \
    --layout=reverse \
    | awk -F':' '{print $1 " +" $2}' \
    | xargs -r sh -c '$EDITOR "$@"' --
end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/wobbat/.opam/opam-init/init.fish' && source '/home/wobbat/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
    '';
  };
}
