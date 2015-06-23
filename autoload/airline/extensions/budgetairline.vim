function! airline#extensions#budgetairline#init(ext)
    call airline#parts#define_function('budgetwidth', 'airline#extensions#budgetairline#budgetwidth')
    call airline#parts#define_function('budgetmode', 'airline#extensions#budgetairline#budgetmode')
endfunction

let s:last_width = -1


function! airline#extensions#budgetairline#trigger()
  let l:width = winwidth(winnr())
  if l:width != s:last_width
    let s:last_width = l:width
    doautocmd User BudgetAirlineRefresh
  endif
  return ''
endfunction


function! airline#extensions#budgetairline#budgetwidth()
  return winwidth(winnr())
endfunction


function! airline#extensions#budgetairline#budgetmode()
  return g:budget_airline_mode
endfunction


" vim: et ts=2 sts=2 sw=2
