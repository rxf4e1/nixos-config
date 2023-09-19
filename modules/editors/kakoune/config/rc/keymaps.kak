# ────────────────────────────────────────────────────
## Normal-Mode
map global normal '<c-f>' %{: fzf-files<ret> }
map global normal '<c-b>' %{: fzf-buffers<ret> }
map global normal '#'     %{: comment<ret>}
map global normal '='     %{: format<ret>}
map global normal '<c-p>' %{: fzf-mode<ret>}

# ────────────────────────────────────────────────────
## User-Mode
map global user 'f' %{: fzf-files<ret> } -docstring 'find files' 
map global user 'b' %{: fzf-buffers<ret> } -docstring 'find buffers'
map global user 'e' %{: broot-right<ret> } -docstring 'file tree'
map global user 'l' %{: enter-user-mode lsp<ret>} -docstring 'LSP'

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
