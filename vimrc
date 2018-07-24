call plug#begin()

"languages
Plug 'vim-ruby/vim-ruby', {'commit': '71f5df7'}
Plug 'fatih/vim-go', {'commit': '3eb57ac'}
Plug 'pangloss/vim-javascript', {'commit': '871ab29'}
Plug 'karthikv/vim-typescript', {'commit': '6fe7b52'}
Plug 'ElmCast/elm-vim', {'commit': '16a9a38'}
Plug 'neovimhaskell/haskell-vim', {'commit': '1862418'}
Plug 'elixir-lang/vim-elixir', {'commit': '1cfd5ab'}
Plug 'rust-lang/rust.vim', {'commit': 'e651851'}
Plug 'zah/nim.vim', {'commit': 'dcf2579'}
Plug '~/Active/par-vim'

"config/templating/extensions
Plug 'elzr/vim-json', {'commit': 'f5e3181'}
Plug 'mxw/vim-jsx', {'commit': 'd0ad98c'}
Plug 'hashivim/vim-terraform', {'commit': 'bfc6ef2'}
Plug 'digitaltoad/vim-pug', {'commit': 'eb8c6b2'}
Plug 'tpope/vim-markdown', {'commit': 'dcdab0c'}
Plug 'wavded/vim-stylus', {'commit': '9ab38f0'}
Plug 'slim-template/vim-slim', {'commit': 'b19d372'}

"misc
Plug 'morhetz/gruvbox', {'commit': '127c9d1'}  "colorscheme
Plug 'w0rp/ale', {'commit': '95be2bf'}  "linting
Plug 'tomtom/tcomment_vim', {'commit': 'c982b13'}  "commenting blocks
Plug 'tpope/vim-surround', {'commit': '1a73f60'}  "change surrounding
Plug 'vim-airline/vim-airline', {'commit': '7b9b68f'}  "status bar
Plug 'karthikv/tradeship-vim', {'commit': '849651d'}  "auto imports
Plug '/usr/local/opt/fzf'  "fuzzy finder

call plug#end()

"enable filetypes (already done by vim-plug, but in case that changes)
filetype plugin indent on
syntax enable

set nocompatible  "no compatibility with vi
set omnifunc=syntaxcomplete#Complete  "omni search
set ruler  "display current cursor position in lower right corner
set hidden  "switch between buffers without saving
set showcmd  "show command on bottom right
set number  "line numbers
set laststatus=2  "always show the status line
set incsearch  "incremental searching
set nofoldenable  "disable code folding
set mousehide  "hide mouse when typing
set splitbelow  "split windows below the current window
set showmode "show current mode
set completeopt=longest,menuone  "code completion
set wildmenu  "more useful command-line completion
set wildmode=list:longest  "auto-completion menu
set mouse=  "mouse selection shouldn't change vim mode; allows cmd + C to work
set rtp+=~/.fzf  "for fzf file searching

"tabs default to two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"smart indenting
set smartindent
set autoindent

"better line wrapping
set wrap
set textwidth=80
set formatoptions=qrn1

"case insensitive search
set ignorecase
set smartcase

"file types
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.epy set filetype=htmldjango
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.ts set filetype=typescript

"gruvbox theme
set background=dark
set termguicolors
colorscheme gruvbox

let g:terminal_color_0 = '#282828'
let g:terminal_color_1 = '#cc241d'
let g:terminal_color_2 = '#98971a'
let g:terminal_color_3 = '#d79921'
let g:terminal_color_4 = '#458588'
let g:terminal_color_5 = '#b16286'
let g:terminal_color_6 = '#689d6a'
let g:terminal_color_7 = '#a89984'
let g:terminal_color_8 = '#928374'
let g:terminal_color_9 = '#fb4934'
let g:terminal_color_10 = '#b8bb26'
let g:terminal_color_11 = '#fabd2f'
let g:terminal_color_12 = '#83a598'
let g:terminal_color_13 = '#d3869b'
let g:terminal_color_14 = '#8ec07c'
let g:terminal_color_15 = '#ebdbb2'

"highlighting
highlight LineNr ctermfg=black
highlight Pmenu ctermbg=grey ctermfg=black
highlight PmenuSel ctermbg=red ctermfg=white

"completion
imap <C-j> <C-n>
imap <C-k> <C-p>

"easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"helpful shortcuts
let mapleader='s'
nmap <Leader>l :vsplit<CR><C-l>
nmap <Leader>j :split<CR>
nmap <Leader>r :redraw!<CR>
nmap <Leader>s :set spell! spell?<CR>
nmap <Leader>h :set hls! hls?<CR>
nmap <Leader>2 :set ts=2 sts=2 sw=2 et<CR>
nmap <Leader>4 :set ts=4 sts=4 sw=4 et<CR>
nmap <Leader>p :set invpaste paste?<CR>
nmap <Leader>v :source %<CR>
nmap <C-p> :FZF<CR>

"line movement
nmap <M-j> :m+<CR>==
nmap <M-k> :m-2<CR>==
imap <M-j> <Esc>:m+<CR>==gi
imap <M-k> <Esc>:m-2<CR>==gi
vmap <M-j> :m'>+<CR>gv=gv
vmap <M-k> :m-2<CR>gv=gv

"spelling corrections
iab teh the
iab Teh The

let g:javascript_plugin_flow = 1  "vim-javascript: enable flow highlighting
let g:jsx_ext_required = 0  "vim-jsx: make .jsx extension not requried
let g:go_fmt_fail_silently = 1  "vim-go: don't complain if fmt fails
let g:go_fmt_command = 'goimports'  "vim-go: use goimports as fmt tool
let g:elm_format_autosave = 1  "elm-vim: format on save

let g:ale_linters = {
\  'typescript': ['tsserver'],
\  'ruby': ['rubocop'],
\}
let g:ale_fixers = {
\  'typescript': ['prettier'],
\}
let g:ale_fix_on_save = 1

"tradeship: import on shortcut
nnoremap <C-A-i> :Tradeship<CR>

"automatically add end braces
inoremap <CR> <C-R>=CleverBrace()<CR>
function! CleverBrace()
  if strpart(getline('.'), col('.') - 2, 1) =~ '{'
    return "\<CR>}\<ESC>O"
  else
    return "\<CR>"
endfunction

"disable indentexpr in erl files
autocmd FileType erlang setlocal indentexpr=
