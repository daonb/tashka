" Glynne Evans 2009

" ------------------ Commands -------------------

" :SendDB, run buffer through isql-fb & w3m
":command! -range=% SendDB :<line1>,<line2>w !isql-fb  -u 'SYSDBA' -p 'masterkey' /usr/share/doc/firebird2.1-examples/examples/empbuild/employee.fdb 2>&1 | w3m
:command! -range=% SendDB :<line1>,<line2>w !isql-fb  -u 'SYSDBA' -p 'masterkey' /home/gglynne/firebird/database/db 2>&1 | w3m

" :Isql, run buffer through isql.py
:command! -range=% Isql :<line1>,<line2>w !./isql.py | w3m

" :PyRun, run buffer through python interpreter & w3m
:command! -range=% PyRun :<line1>,<line2>w !python %s | w3m

" :Ipy, run buffer through ipython
:command! -range=% Ipy :!ipython -nobanner -noconfirm_exit %

" :Html, run buffer through markdown & preview in firefox
:command! -range=% Html : !markdown % > %.html && firefox %.html<cr>

" ------------------------------------------------------

" comma-separated search paths for gf command (,,= current dir)
set path=,,~

" keep X lines on the screen when scrolling, useful for coding
" viemu status: http://www.viemu.com/forums/viewtopic.php?id=511
set scrolloff=4

" easy on eyes

if has("gui_running")
        colorscheme darkblue
else
        colorscheme ron
endif


" -------------------- overall appearance ----------------------

" hide menu bar
set guioptions=

" nice big font
set guifont=Monospace\ 16

" do not wrap lines
set nowrap

" allow the cursor to wrap on anything
set whichwrap=b,s,h,l,<,>,[,]

" make backspace work like other editors
set backspace=indent,eol,start

" backspace = insert mode
nmap <backspace> i

" stop mouse events screwing up cursor position on laptop touchpad
set mouse=

" show <line number>,<column number>  <realtive position of displayed text>%
set ruler

" use autoindentation
set ai

" we have a fast terminal connection
set ttyfast

" write buffers automagically when leaving them
set autowrite

" recognize ^M files
set textauto

" check one line for commands in each file
set modelines=1

" insert sw spaces when using tab in front of a line
set smarttab

" insert tabs as spaces
set expandtab

" set incremental search
set incsearch

" do not highlight all search results
set nohlsearch

" suffixes to put to the end of the list when completing file names
set suffixes=.bak,~,.o,.h,.info,.swp,.class

" patterns to put to ignore when completing file names
set wildignore=*.bak,~,*.o,*.info,*.swp,*.class

" wildmode: complete to longest match, list on second tab
set wildmode=longest,list,full

set wildmenu " Show enhanced command line completion 

" jump to matching bracket when entered
set showmatch 
set matchtime=3

" turn off highlighting of matching bracket
" visual studio: http://msdn.microsoft.com/en-us/library/be94e8aw(VS.80).aspx
let g:loaded_matchparen= 1

" save command line history, search string history etc. 
" use :h viminfo for more detais
set viminfo='50,"1000,:50,n~/.viminfo

" get syntax highlighting
syntax on
if version >= 600
  filetype plugin on
  filetype indent on
endif

" you nearly always want this
set ignorecase
" overrides ignorecase if uppercase used in search string
set smartcase

" always cd to a files directory
autocmd BufEnter * lcd %:p:h

" the character to show at start of lines that have been wrapped
set showbreak="\0376" 

" ---------------------- backup policy -------------------------

" create backups
set backup

" the backup extension
set bex=.bak

" See `Platform-specific` for the backupdir

" ---------------------- keys ----------------------------------

" if only i knew about this one at the beginning...
imap jj <Esc>

" C-N = next bufer
map <C-n> :exe  ":buf ".((bufnr("%") % bufnr("$"))+1)<CR> 

" C-P = previous bufer
map <C-p> :exe  ":buf ".(bufnr('%') == 1 ? bufnr('$') : bufnr('%')-1)<CR>

" S-K : google the word under the cursor
set keywordprg=~/scripts/google.sh

" C-T opens a new tab
noremap <C-t> :tabnew<cr>

" cu = count up = increment number
nmap cu <c-a>

" cd = count down = decrement number
nmap cd <c-a>


" space = page down
noremap <space> <c-d>

" C-n = cycle buffers. Note that <C-6> switches to previously displayed.
map <C-n> :exe  ":buf ".((bufnr("%") % bufnr("$"))+1)<CR>

" f1 = try and play the file name at the cursor (xxx.ext) with mpplayer
map <f1> 0veeey:!mplayer -fs <C-R>"<Esc><Esc>j
imap <f1> 0veeey:!mplayer -fs <C-R>"<Esc><Esc>j

" f2 = play macro q
nmap <f2> @q

" f3 = search all buffers
map <f3> :Bgrep 

" f4 = recursively search files
map <f4> :Rgrep<CR>

" f5 = RUN
" map <f5> :w<cr>:source %<cr> | imap <f5> <esc>:w<cr>:source %<cr>
" map <f5> :Isql<cr> | map <f5> <esc>:Isql<cr>
" map <f5> :PyRun<cr> | map <f5> <esc>:PyRun<cr>
" map <f5> :Ipy<cr> | map <f5> <esc>:Ipy<cr>
" map <f5> :SendDB<cr> | map <f5> <esc>:SendDB<cr>

" f7 = open notes in bottom window
map <f7> :sp notes<CR><C-w><C-r><C-w><C-w>

" vv = take notes (copy word or selection to bottom window)
map vv "zyw<C-w>wo<Esc>"zgpzz<C-w>w

" f8 = toggle file structure in left window
nnoremap <silent> <f8> :TlistToggle<CR> 

" f9 = change tab completion
nnoremap <f9> :SuperTabHelp<cr>

" f10 = filter thru markdown and preview in firefox 
nmap <f10> :w<cr>:!markdown % > %.html && firefox %.html<cr>
imap <f10> <esc>:w<cr>:!markdown % > %.html && firefox %.html<cr>

" F12 = open vifm ~ <curdir>
nmap <f12> :!vifm ~ ./<cr><cr>
imap <f12> :!vifm ~ ./<cr><cr>
                        
" C-b = filter thru markdown, upload to blogger.com by google docs api
nmap <c-b> :w<cr>:!markdown % > %.html<cr>:!python ~/scripts/upload.py ennylg password %.html

" H=^,L=$
nmap H ^
nmap L $

" make $ exclusive in visual mode,
vmap $ $<c-v>
vmap L $
vmap H ^

" 

" c-H & c-l scroll window left & right
nmap <c-h> zh
nmap <c-l> zl

" enable local .vimrc
set exrc

" ------------------------------Platform-specific --------------------

" Where to search for plugins, syntax files, etc. 
" :echo $VIMRUNTIMEPATH
" Unix:  $HOME/.vim,                Windows:     $HOME/vimfiles,
"        $VIM/vimfiles,                          $VIM/vimfiles,
"        $VIMRUNTIME,                            $VIMRUNTIME,
"        $VIM/vimfiles/after,                    $VIM/vimfiles/after
"        $HOME/.vim/after                        $HOME/vimfiles/after

"set runtimepath=$VIMRUNTIME,~/vimfiles

"NB: uncommented above to use ~/.vim/

" where to save this `.bak` files
set backupdir=~/tmp,.,~/,/tmp

" set shell
set sh=/bin/bash 


" save views on all files types in ~/.vim/view
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" java auto-completion
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" syntax file for markdown files
augroup markdown 
        au! BufRead,BufNewFile *.mkd setfiletype mkd 
augroup END 

au! Syntax mkd source ~/.vim/plugin/mkd.vim 

augroup mkd 
        autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:> 
augroup END 


