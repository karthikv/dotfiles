"no comaptibility with vi
set nocompatible

"enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

"display current cursor position in lower right corner.
set ruler

"switch between buffers without saving
set hidden

"tabs default to two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"show command on bottom right
set showcmd

"line numbers
set number

"smart indenting
set smartindent
set autoindent

"always show the status line
set laststatus=2

"better line wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

"set incremental searching
set incsearch

"case insensitive search
set ignorecase
set smartcase

"disable code folding
set nofoldenable

"hide mouse when typing
set mousehide

"split windows below the current window.
set splitbelow

"session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

"leader key
let mapleader='s'

"shortcut for editing vimrc file in a new tab
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"faster shortcut for commenting. Requires T-Comment plugin
map <Leader>c <c-_><c-_>

"saves time; maps the spacebar to colon
nmap <space> :

"code completion
imap <C-j> <C-n>
imap <C-k> <C-p>
set completeopt=longest,menuone

"more useful command-line completion
set wildmenu

"auto-completion menu
set wildmode=list:longest

"source the vimrc file after saving it
if has("autocmd")
 augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
 augroup END
endif

"easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"CommandT Plugin Settings
nmap <C-p> :CommandT<CR>
nmap <C-f> :CommandTFlush<CR>
set wildignore=.git,node_modules
let g:CommandTMaxHeight=10
let g:CommandTCancelMap=['<C-c>', '<Esc>']

"helpful shortcuts
nmap <Leader>l :vsplit<CR><C-l>
nmap <Leader>j :split<CR>
nmap <Leader>r :redraw!<CR>
nmap <Leader>s :set spell! spell?<CR>
nmap <Leader>h :set hls! hls?<CR>
nmap <Leader>2 :set ts=2 sts=2 sw=2 et<CR>
nmap <Leader>4 :set ts=4 sts=4 sw=4 et<CR>
nmap <Leader>p :set invpaste paste?<CR>
nmap <C-t> :tabnew<CR>
nmap ˙ :tabprev<CR>
nmap ¬ :tabnext<CR>
nmap <C-w><C-w> :q<CR>

"end brace shortcut
function! CleverBrace()
  if strpart( getline('.'), col('.')-2, 1 ) =~ '{'
    return "\<CR>}\<ESC>O"
  else
    return "\<CR>"
endfunction
inoremap <CR> <C-R>=CleverBrace()<CR>

"spelling corrections
iab teh the
iab Teh The

"commands
command! Run ! rcc %

"show current mode
set showmode

"file types
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.epy set filetype=htmldjango

"highlighting
highlight LineNr ctermfg=black
highlight Pmenu ctermbg=grey ctermfg=black
highlight PmenuSel ctermbg=red ctermfg=white

"line movement
nmap ∆ :m+<CR>==
nmap ˚ :m-2<CR>==
imap ∆ <Esc>:m+<CR>==gi
imap ˚ <Esc>:m-2<CR>==gi
vmap ∆ :m'>+<CR>gv=gv
vmap ˚ :m-2<CR>gv=gv
