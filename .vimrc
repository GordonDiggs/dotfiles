execute pathogen#infect()

set nocompatible                  " Must come first because it changes other options.

colorscheme slate

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set nowrap                        " Don't wrap lines of text

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ \|%{GitBranch()}\|\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set cursorcolumn
set autoread

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

map <Leader>t :FuzzyFinderTextMate<Enter>
map <Leader>] :NERDTree<Enter>
map <leader>= :source $MYVIMRC<Enter>
map <Leader>q :noh<Enter>
map <Leader>g :Gbrowse<Enter>
map <Leader>p :CtrlP<Enter>

au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.js set filetype=javascript syntax=jquery

" The following automatically runs gofmt when you save a buffer. Makes it easy
" to follow formatting rules and always keep your code according to standard.
"if has('autocmd')
"    augroup gofmtBuffer
"    au!
"    autocmd BufWritePre *.go :call GoFormatBuffer()
"    augroup END
"endif
"function! GoFormatBuffer()
"    let curr=line(".")
"    %!/usr/local/go/bin/gofmt
"    call cursor(curr, 1)
"endfunction
au BufWritePost *.go !gofmt -w %

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,ruby,javascript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

com! FormatJSON %!python -m json.tool

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
