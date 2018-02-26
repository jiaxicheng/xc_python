"general set
    syn on
    set nocompatible
    set showmatch 
    set nocindent
   "set showcmd
   "set ruler 
    set incsearch
    set hlsearch
    set hidden
    set ai 
    "set mouse=a
    "set mouse=n
    set whichwrap=b,s,<,>,[,]
    "colorscheme evening
    colorscheme zellner

"set for taglist
    "filetype on
    "nnoremap <silent><F8> :Tlist<CR>
    let Tlist_WinWidth = 26

"set for miniBufExplore 
    let g:miniBufExplMapWindowNavVim = 1 
    let g:miniBufExplMapWindowNavArrows = 1 
    let g:miniBufExplMapCTabSwitchBuffs = 1
    let g:miniBufExplModSelTarget = 1 
    map \t :TMiniBufExplorer<cr>

"set for markword.vim
    map \m :call MarkWord()<cr>
    map \c :call MarkNone()<cr>

"set for vimspell.vim
"     highlight SpellErrors ctermbg=Red ctermfg=White guibg=Red guifg=White term=reverse

"set mapping keys
    map <F4> :set paste!<CR>:set nopaste?<CR>
    map <F5> <C-W>W<Tab><CR>
    map <F6> :set nu!<CR>:set nu?<CR>
    map <F7> :if exists("syntax_on")<bar>syn off<bar>else<bar>syn on<bar>endif<C-M>
    map <F8> :Tlist<CR>
    map <F9> <C-W>W
    map <F10> :se nocindent!<CR>:se cindent?<cr>
"    map <Tab> i<CR><CR><CR><CR>
"     map <F11> <Leader>ss!<Esc>
"     map <F12> <Leader>sq!<Esc>

"abbreviations
    iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"restore the cursor to the file position in previous editing session
"set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

au syntax mason so /usr/share/vim/vim72/syntax/mason.vim
au BufNewFile,BufRead *.{mas,mhtml,mpl,html,mtxt} set ft=mason
au BufNewFile,BufRead {auto,d,sys}handler set ft=mason

au syntax css so /usr/share/vim/vim72/syntax/css.vim
au BufNewFile,BufRead *.{m,c}ss set ft=css

au syntax javascript so /usr/share/vim/vim72/syntax/javascript.vim
au BufNewFile,BufRead *.{m,}js set ft=javascript

au syntax xml so /usr/share/vim/vim72/syntax/xml.vim
au BufNewFile,BufRead *.{rss,xml} set ft=xml

au BufReadCmd *.prpt call zip#Browse(expand("<amatch>"))

set tabstop=4      "An indentation level every four columns"
set expandtab      "Convert all tabs typed into spaces"
set shiftwidth=4   "Indent/outdent by four columns"
set shiftround     "Always indent/outdent to the nearest tabstop"

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
