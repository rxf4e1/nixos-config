# ────────────────────────────────────────────────────
## Load full default library (Uncomment only on first time).
#nop %sh{
#    mkdir -p "$kak_config/autoload"
#    ln -s "$kak_runtime/rc" "$kak_config/autoload/standard-library"
#}
 
# ────────────────────────────────────────────────────
## Return shell command inside kakoune
define-command sh -params .. %{ info -title "%arg{@}" %sh{${@} 2>&1 } }
complete-command sh shell

# ────────────────────────────────────────────────────
## fuzzy open file
define-command fuzzy-open-file %{
    try %sh{
        foot -d error --app-id=float sh -c "kak_open_file.sh $kak_session $kak_client"
    }
}

## broot
declare-option str kak_open "%val{config}/kak_open"
define-command broot -docstring "open broot" -params .. %{
  # try %sh{
  terminal sh -c "EDITOR=%opt{kak_open} KAK_SESSION=%val{session} KAK_CLIENT=%val{client} broot %arg{@}"
    # foot -d error --app-id=float sh -c "EDITOR=%opt{kak_open} KAK_SESSION=%val{session} KAK_CLIENT=%val{client} broot %arg{@}"
  # }
}
complete-command broot file

# ────────────────────────────────────────────────────
## System clipboard handling
# TODO: Move keybindins
evaluate-commands %sh{
    if [ -n "$SSH_TTY" ]; then
        copy='printf "\033]52;;%s\033\\" $(base64 | tr -d "\n") > $( [ -n "$kak_client_pid" ] && echo /proc/$kak_client_pid/fd/0 || echo /dev/tty )'
        paste='printf "paste unsupported through ssh"'
        backend="OSC 52"
    else
        case $(uname) in
            Linux)
                if [ -n "$WAYLAND_DISPLAY" ]; then
                    copy="wl-copy -p"; paste="wl-paste -p"; backend=Wayland
                else
                    copy="xclip -i"; paste="xclip -o"; backend=X11
                fi
                ;;
            Darwin)  copy="pbcopy"; paste="pbpaste"; backend=OSX ;;
        esac
    fi

    printf "map global clip -docstring 'paste (after) from clipboard' p '<a-!>%s<ret>'\n" "$paste"
    printf "map global clip -docstring 'paste (before) from clipboard' P '!%s<ret>'\n" "$paste"
    printf "map global clip -docstring 'yank to primary' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to %s primary}<ret>'\n" "$copy" "$backend"
    printf "map global clip -docstring 'yank to clipboard' Y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to %s clipboard}<ret>'\n" "$copy -selection clipboard" "$backend"
    printf "map global clip -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
    printf "define-command -override echo-to-clipboard -params .. %%{ echo -to-shell-script '%s' -- %%arg{@} }" "$copy"
}

# ────────────────────────────────────────────────────
## Utilities
define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }

# Tabs to Spaces
hook global InsertChar \t %{ exec -draft h@ }

# ────────────────────────────────────────────────────
