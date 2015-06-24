# vim-budget-airline

An even cheaper way to fly


I really like the
[vim-airway](https://github.com/bling/vim-airline) vim
plugin, but often I'm using narrow windows for coding and so
information ends up hidden.  By having the information more
compact at smaller window sizes less is lost, but still
allow looking totally swish on a wider window.  This plugin
dynamically saves space as and when need.


This is how we save space on our budget:

- make the mode indicator smaller

- make the file position indicator progressively smaller

- make the file type indicator progressively smaller

- remove some of the padding around sections

- remove padding between section components

- remove the section dividers


## Install:

### Requirements

`vim-airline` is needed for this plugin

### Vundel

`Plugin 'tobes/vim-budget-airline'`

### Setup and Config

we need to **get airline to show as much info as it can** so put some thing
like this in you `.vimrc`

`let g:airline#extensions#default#section_truncate_width = {}`


**vim-budget-airline config options**

`g:airline#extensions#budgetairline#enabled`


### Commands:


`:BudgetAirlineEnable`

`:BudgetAirlineDisable`


### Tiny Budget

Flying on a shoestring means no carry on baggage.  we need to ditch everything
we can.  It might not look pretty but most of the important stuff is
here.Remove all padding and separators where possible, and shrink any controls
we know how.

**vim-budget-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/budget-35.png)

**vim-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/airline-35.png)


### Small Budget

With a carry on bag allowance with this flight we have a little more room. We
can have some of the styling but keep the padding to a minimum and keep them
controls small if possible.

**vim-budget-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/budget-65.png)

**vim-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/airline-65.png)


###  Medium Budget

Actually got some leg room! We can use the default settings but shrink a few of
the controls (mode, file position info) as we've still got a weight limit.

**vim-budget-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/budget-85.png)

**vim-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/airline-85.png)


###  First Class

We can relax and just use all the goodness of vim-airline.  Use defaults.

**vim-budget-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/budget-95.png)

**vim-airline**

![img](https://github.com/tobes/vim-budget-airline/wiki/screenshots/airline-95.png)
