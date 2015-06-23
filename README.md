# vim-budget-airline

An even cheaper way to fly


I really like the vim-airway plugin, but often I'm using narrow windows for
coding and so information ends up hidden.  By having the information more
compact at smaller window sizes less is lost, but still allow looking
totally swish on a wider window.


This is how we save space on our budget:

- make the mode indicator smaller

- make the file position indicator progressively smaller

- remove some of the padding around sections

- remove padding between section components

- remove the section dividers



## Install:

### Requirements

`vim-airline` is needed for this plugin

### Vundel

`Plugin 'tobes/vim-budget-airline'`

### Config

we need to get airline to show as much info as it can so put some thing like this in you `.vimrc`

`let g:airline#extensions#default#section_truncate_width = {}`


## Commands:

`:BudgetAirlineEnable`

`:BudgetAirlineDisable`

