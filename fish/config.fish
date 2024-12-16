# ╭──────────────────────────────────────────────────────────╮
# │ Sources                                                  │
# ╰──────────────────────────────────────────────────────────╯
starship init fish | source
fzf --fish | source
zoxide init fish | source

# ╭──────────────────────────────────────────────────────────╮
# │ Env variables                                            │
# ╰──────────────────────────────────────────────────────────╯
fish_add_path /home/domi/.spicetify

# ╭──────────────────────────────────────────────────────────╮
# │ Themes                                                   │
# ╰──────────────────────────────────────────────────────────╯
# You may have to update the bat cache with: bat cache --build
export BAT_THEME="Catppuccin Mocha"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# ╭──────────────────────────────────────────────────────────╮
# │ Fish shell                                               │
# ╰──────────────────────────────────────────────────────────╯
set fish_greeting

# Enable vim keybindings (without changing some useful default shortcuts)
fish_hybrid_key_bindings
bind yy fish_clipboard_copy
bind p fish_clipboard_paste
bind -M insert -m default jk backward-char force-repaint

# use "emoji" to search for unicodes (in kitten)
alias emoij="kitten unicode-input"

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

# ╭──────────────────────────────────────────────────────────╮
# │ Aliases                                                  │
# ╰──────────────────────────────────────────────────────────╯
# Logout
alias logout="gnome-session-quit"

# Hibernate
alias hibernate="sudo systemctl hibernate"

# Neovim
alias vim="nvim"
alias vi="nvim"

# Set alias svim to open nvim with sudo rights
alias svim="sudo -s -E nvim"

# Lazygit
alias lg="lazygit"

# Zoxide
abbr --erase z &>/dev/null
alias z=__zoxide_z
alias cd=__zoxide_z

abbr --erase zi &>/dev/null
# Query matching directories
alias zz=__zoxide_zi

abbr --erase zr &>/dev/null
# Remove current directory from the database
alias zr=__zoxide_forget_zr

# Eza (better ls)
alias ls="eza --oneline --group-directories-first --icons --hyperlink"

# Use eza instead of tree
alias tree="eza --tree --group-directories-first --icons"

# Zoxide (better cd)
alias cd="z"

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

# ╭──────────────────────────────────────────────────────────╮
# │ Node js                                                  │
# ╰──────────────────────────────────────────────────────────╯
set -gx PNPM_HOME "/home/domi/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# ╭──────────────────────────────────────────────────────────╮
# │ Zoxide                                                   │
# ╰──────────────────────────────────────────────────────────╯
# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
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

# Completions.
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# Function to forget the current directory in zoxide.
function __zoxide_forget_zr
    command zoxide remove -- (__zoxide_pwd)
end

