function! budgetairline#append(text, minwidth)
  if a:minwidth > 0 && winwidth(0) < a:minwidth
    return ''
  endif
  let prefix = g:budget_airline_spc_p == "\ua0" ? g:budget_airline_spc_p : g:budget_airline_spc_p.g:budget_airline_spc_p
  return empty(a:text) ? '' : prefix.g:airline_left_alt_sep.g:budget_airline_spc_p.a:text
endfunction


function! budgetairline#prepend(text, minwidth)
  if a:minwidth > 0 && winwidth(0) < a:minwidth
    return ''
  endif
  return empty(a:text) ? '' : a:text.g:budget_airline_spc_p.g:airline_right_alt_sep.g:budget_airline_spc_p
endfunction


let s:file_shorts = {
      \ 'python': 'py',
      \ 'javascript': 'js',
      \}

function! budgetairline#filetype()
  let l:ft = &filetype
  if g:budget_airline_mode < 2
    return l:ft
  endif
  return get(s:file_shorts, l:ft, l:ft)
endfunction


let s:ff = {
      \ 'unix': 'u',
      \ 'dos': 'd',
      \ 'mac': 'm',
      \}

function! budgetairline#ffenc()
  if g:budget_airline_mode > 2
    return printf('%s', &fenc)
  elseif g:budget_airline_mode > 0
    return printf('%s%s', &fenc, strlen(&ff) > 0 ? ':'. get(s:ff, &ff) : '')
  else
    return printf('%s%s', &fenc, strlen(&ff) > 0 ? '['.&ff.']' : '')
  endif
endfunction


" vim: et ts=2 sts=2 sw=2
