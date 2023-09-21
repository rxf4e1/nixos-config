# ────────────────────────────────────────────────────
## Normal-Mode
map global normal '#'     %{: comment<ret>}
map global normal '='     %{: format<ret>}
map global normal '<c-f>' %{: fuzzy-open-file<ret> }

# ────────────────────────────────────────────────────
## User-Mode
# map global user e %{: br<ret> } -docstring 'edit'
map global user e %{: broot<ret> } -docstring 'edit file'
map global user l %{: enter-user-mode lsp<ret> } -docstring 'lsp'

declare-user-mode kill
map global kill b ': delete-buffer<ret>' -docstring 'kill'
map global user d ': enter-user-mode kill<ret>' -docstring 'delete'
declare-user-mode clip
map global user c ': enter-user-mode clip<ret>' -docstring 'clipboard'

# ────────────────────────────────────────────────────
## Better Escape
hook global InsertChar j %{ try %{
  exec -draft hH <a-k>kj<ret> d
  exec <esc>
}}
hook global InsertChar j %{ try %{
  exec -draft hH <a-k>jj<ret> d
  exec <esc>
}}

# ────────────────────────────────────────────────────
# Better Comment
define-command comment %{
  try %{
    execute-keys _
    comment-block
  } catch comment-line
}

# ────────────────────────────────────────────────────
## Tab Completion
# hook global InsertCompletionShow .* %{
#   try %{
#     execute-keys -draft 'h<a-K>\h<ret>'
#     map window insert <tab> <c-n>
#     map window insert <s-tab> <c-p>
#     hook -once -always window InsertCompetionHide .* %{
#       map window insert <tab> <tab>
#       map window insert <s-tab> <s-tab>
#     }
#   }
# }
