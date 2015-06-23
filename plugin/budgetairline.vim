" Budget-Airline - a heaper way to fly
" MIT License. Copyright (c) Toby Dacre 2015
" vim: et ts=2 sts=2 sw=2

" check airline extension is loaded
if !exists('g:loaded_airline')
  finish
endif

" check if disabled
if exists('g:airline#extensions#budgetairline#enabled')
  if !g:airline#extensions#budgetairline#enabled
    finish
  endif
endif


function! s:initialize()

  " names of the default airline sections
  let s:section_names = [
        \ 'a', 'b', 'c', 'x', 'y', 'z',
        \ 'gutter', 'warning'
  \ ]

  " airline settings we want to be able to override
  let s:airline_settings = [
        \ 'mode_map',
        \ 'left_sep',
        \ 'right_sep',
        \ 'right_alt_sep',
        \ 'left_alt_sep',
  \ ]

  let s:cache = {}
  let s:sections = {}
  let s:subs = {}

  " space if special so store here
  let s:cache.symbols_space = g:airline_symbols.space

  for setting in s:airline_settings
    let s:cache[setting] = g:{'airline_' . setting}
  endfor

  if !exists('g:airline#extensions#budget#mode_map')
    let g:airline#extensions#budget#mode_map= {}
  endif

  call extend(g:airline#extensions#budget#mode_map, {
      \ '__' : '--',
      \ 'n'  : 'n',
      \ 'i'  : 'i',
      \ 'R'  : 'R',
      \ 'v'  : 'v',
      \ 'V'  : 'V',
      \ 'c'  : 'c',
      \ '' : '^V',
      \ 's'  : 's',
      \ 'S'  : 'S',
      \ '' : '^S',
      \ 't'  : 't',
      \ }, 'keep')


  " we want to override the position info as it takes
  " up lots of space
  let s:default_position = airline#section#create(
        \ ['%3p%%' . g:airline_symbols.space, 'linenr', ':%3v ']
  \ )

  let s:substituions = [
        \ ['airline#util#append', 'budgetairline#append'],
        \ ['airline#util#prepend', 'budgetairline#prepend'],
        \ ['airline#parts#ffenc', 'budgetairline#ffenc'],
        \ ['airline#parts#filetype', 'budgetairline#filetype'],
        \ [s:default_position, '{{POSITION}}']
  \ ]

  call airline#parts#define_raw('budgetairline_line_nr', '%l')
  call airline#parts#define_accent('budgetairline_line_nr', 'bold')

  let s:subs['{{POSITION}}'] = {
        \ 0: s:default_position,
        \ 1: airline#section#create(['%p%% ', 'budgetairline_line_nr', ':%2c']),
        \ 2: airline#section#create(['budgetairline_line_nr', ':%2c']),
        \ 3: airline#section#create(['budgetairline_line_nr']),
  \ }

  for section in s:section_names
    let s:cache[section] = g:{'airline_section_' . section}
    let s:sections[section] = s:process_section(s:cache[section])
  endfor

  let g:budget_airline_spc_p = g:airline_symbols.space

  let s:initialized = 1
  let s:enabled = 1
  let s:budget_airline_last_mode = -1

  let s:width_last = -1
  call s:resize()
endfunction


if has("autocmd")
  augroup BudgetAirlineAutoCmds
    autocmd!
    autocmd VimEnter * call s:initialize()
    autocmd User BudgetAirlineRefresh call s:resize()
  augroup END
endif


function! s:resize()
  if !exists('s:initialized') || !s:enabled
    return
  endif

  let s:width = winwidth(winnr())
  if s:width_last == s:width
    return
  endif

  let s:width_last =  s:width

  let l:width = winwidth(winnr())
  if l:width > 90
    let g:budget_airline_mode = 0
  elseif l:width > 65
    let g:budget_airline_mode = 1
  elseif l:width > 40
    let g:budget_airline_mode = 2
  else
    let g:budget_airline_mode = 3
  endif

  let s:budget_airline_last_mode = -1

  if g:budget_airline_mode != s:budget_airline_last_mode
    let s:budget_airline_last_mode = g:budget_airline_mode
    if g:budget_airline_mode == 0
      call s:budgetRemove()
    elseif g:budget_airline_mode == 1
      call s:budgetMedium()
    elseif g:budget_airline_mode == 2
      call s:budgetSlim()
    else
      call s:budgetTiny()
    endif
  endif
endfunction


function! s:set_airline_sections()
  for section in s:section_names
    let l:data = s:sections[section]
    " perform substitutions for raw strings
    for sub in keys(s:subs)
      let l:data = substitute(l:data, sub, s:subs[sub][g:budget_airline_mode], 'g')
    endfor
    let g:{'airline_section_' . section} = l:data
  endfor
endfunction


function! s:reset_airline_settings()
  " restore general settings
  for setting in s:airline_settings
    let g:{'airline_' . setting} = s:cache[setting]
  endfor
  let g:airline_symbols.space = s:cache.symbols_space
endfunction


function! s:process_section(section)
  let l:section = a:section
  for item in s:substituions
    let l:section = substitute(l:section, item[0], item[1], 'g')
  endfor
  " add our trigger for window size changes
  return '%{airline#extensions#budgetairline#trigger()}' . l:section
endfunction


function! s:budgetTiny()
  call s:reset_airline_settings()
  call s:set_airline_sections()
  let g:airline_symbols.space = ''
  let g:airline_mode_map = g:airline#extensions#budget#mode_map
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = '|'
  let g:airline_left_alt_sep = '|'
  let g:budget_airline_spc_p = ''
  :AirlineRefresh
endfunction


function! s:budgetSlim()
  call s:reset_airline_settings()
  call s:set_airline_sections()
  let g:airline_symbols.space = ''
  let g:airline_mode_map = g:airline#extensions#budget#mode_map
  let g:budget_airline_spc_p = ''
  :AirlineRefresh
endfunction


function! s:budgetMedium()
  call s:reset_airline_settings()
  call s:set_airline_sections()
  let g:airline_mode_map = g:airline#extensions#budget#mode_map
  let g:budget_airline_spc_p = s:cache.symbols_space
  :AirlineRefresh
endfunction


function! s:budgetRemove()
  call s:reset_airline_settings()
  call s:set_airline_sections()
  let g:budget_airline_spc_p = s:cache.symbols_space
  :AirlineRefresh
endfunction


function! s:budgetEnable()
  let s:enabled = 1
  let s:budget_airline_last_mode = -1
  let s:width_last = -1
  call s:resize()
endfunction

function! s:budgetDisable()
  let s:enabled = 0
  let g:budget_airline_mode = 0
  call s:budgetRemove()
  " restore airline sections
  for section in s:section_names
    let g:{'airline_section_' . section} = s:cache[section]
  endfor
endfunction


command! BudgetAirlineEnable call s:budgetEnable()
command! BudgetAirlineDisable call s:budgetDisable()
