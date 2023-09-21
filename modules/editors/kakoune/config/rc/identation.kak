## Tab Completion
hook global InsertCompletionShow .* %{
  try %{
    execute-keys -draft 'h<a-K>\h<ret>'
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
    hook -once -always window InsertCompetionHide .* %{
      map window insert <tab> <tab>
      map window insert <s-tab> <s-tab>
    }
  }
}

