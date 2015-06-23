function! airline#extensions#budgetairline#init(ext)
    call airline#parts#define_function('budgetwidth', 'airline#extensions#budgetairline#budgetwidth')
    call airline#parts#define_function('budgetmode', 'airline#extensions#budgetairline#budgetmode')
endfunction


function! airline#extensions#budgetairline#budgetwidth()
  return winwidth(winnr())
endfunction


function! airline#extensions#budgetairline#budgetmode()
  return g:budget_airline_mode
endfunction


" vim: et ts=2 sts=2 sw=2
