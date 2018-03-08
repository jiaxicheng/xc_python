"filetype plugin on
syntax on
set tabstop=2

"au syntax python so /usr/share/vim/vim74/syntax/python.vim
"au BufNewFile,BufRead *.py set ft=python

"set mapping keys
    map <F4> :set paste!<CR>:set nopaste?<CR>
    map <F5> <C-W>W<Tab><CR>
    map <F6> :set nu!<CR>:set nu?<CR>
    map <F7> :if exists("syntax_on")<bar>syn off<bar>else<bar>syn on<bar>endif<C-M>
    map <F8> :Tlist<CR>
    map <F9> <C-W>W
    map <F10> :se nocindent!<CR>:se cindent?<cr>

"set for miniBufExplore 
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 1
    let g:miniBufExplMapCTabSwitchBuffs = 1
    let g:miniBufExplModSelTarget = 1
    map \t :TMiniBufExplorer<cr>

