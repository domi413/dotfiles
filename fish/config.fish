# ╭──────────────────────────────────────────────────────────╮
# │ Sources                                                  │
# ╰──────────────────────────────────────────────────────────╯
starship init fish | source
fzf --fish | source
zoxide init fish | source

# ╭──────────────────────────────────────────────────────────╮
# │ Env variables                                            │
# ╰──────────────────────────────────────────────────────────╯
# GO
set -gx GOPATH "$HOME/.go"
fish_add_path "$GOPATH/bin"

# Disable `ctrl+shift+u` unicode input
set -gx GTK_IM_MODULE none

# ╭──────────────────────────────────────────────────────────╮
# │ Themes                                                   │
# ╰──────────────────────────────────────────────────────────╯
# INFO: You may have to update the bat cache with: bat cache --build

### Bat
export BAT_THEME="Catppuccin Mocha"

### Fuzzy finder
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi \
--bind 'enter:execute-silent(readlink -f {} | wl-copy)+accept'"

# ╭──────────────────────────────────────────────────────────╮
# │ Fish shell                                               │
# ╰──────────────────────────────────────────────────────────╯
set fish_greeting
set -U fish_color_command blue

# Enable vim keybindings (without changing some useful default shortcuts)
fish_hybrid_key_bindings
bind yy fish_clipboard_copy
bind p fish_clipboard_paste
bind -M insert -m default jk backward-char force-repaint

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

# ╭──────────────────────────────────────────────────────────╮
# │ Aliases                                                  │
# ╰──────────────────────────────────────────────────────────╯
### System
# Logout
alias logout="gnome-session-quit"

# Hibernate
alias hibernate="sudo systemctl hibernate"

### Fastfetch
alias ff="fastfetch"

### Neovim
alias vim="nvim"
alias vi="nvim"

# Open nvim with sudo rights
alias svim="sudo -s -E nvim"

### Lazygit
alias lg="lazygit"

### Bat
alias grep="batgrep"
alias man="batman"
alias diff="batdiff"

### Zoxide
alias z=__zoxide_z
alias cd=__zoxide_z

# Query matching directories
alias zz=__zoxide_zi

# Remove current directory from the database
alias zr=__zoxide_forget_zr

### Eza (better ls)
alias ls="eza --oneline --group-directories-first --icons --hyperlink"

# Use eza instead of tree
alias tree="eza --tree --group-directories-first --icons --hyperlink"

### fzf (fuzzy finder)
alias f="fzf --height 40% --layout reverse --border"

# Fuzzy find with preview
# NOTE: You may have to run: bat cache --build
alias fp='fzf --preview="bat --color=always {}"'

# rga-fzf
alias fr='rga-fzf'

# Zed
alias zed="zeditor"

# ╭──────────────────────────────────────────────────────────╮
# │ Custom Functions                                         │
# ╰──────────────────────────────────────────────────────────╯
function do --description "Rerun the last command using sudo"
    if test (count $argv) -eq 0
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

function mkd --description "Create a file or directory with its parent directories"
    if test (count $argv) -eq 0
        echo -e "Combines the functionality of mkdir and touch\n"
        echo "Usage: mkd <path/to/file>"
        echo "Usage: mkd <path/to/dir/>"
        return 1
    end

    set target $argv[1]

        if string match -r '.*/$' $target > /dev/null
        mkdir -p $target < /dev/null
    else
        set dir (dirname $target)
        mkdir -p $dir; and touch $target
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function yazi_zed
    set -l tmp (mktemp -t "yazi-chooser.XXXXX")
    yazi $argv --chooser-file="$tmp"
    set -l opened_file (head -n 1 "$tmp")

    zed -- "$opened_file"
    rm -f -- "$tmp"
end

function fyi --description "Searching for AUR-/Pacman-packages"
    yay -Slq | fzf -q "$argv" -m --preview 'yay -Si {1}' | xargs -ro yay -S
end

function fyr --description "Removing installed package"
    yay -Qq | fzf -q "$argv" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
end

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

