call plug#begin()

"languages
Plug 'fatih/vim-go', {'commit': '3eb57ac'}
Plug 'pangloss/vim-javascript', {'commit': '871ab29'}
Plug 'ElmCast/elm-vim', {'commit': '16a9a38'}
Plug 'dag/vim2hs', {'commit': 'f2afd55'}
Plug 'elixir-lang/vim-elixir', {'commit': '1cfd5ab'}
Plug 'rust-lang/rust.vim', {'commit': 'e651851'}

"config/templating/extensions
Plug 'elzr/vim-json', {'commit': 'f5e3181'}
Plug 'mxw/vim-jsx', {'commit': 'd0ad98c'}
Plug 'hashivim/vim-terraform', {'commit': 'bfc6ef2'}
Plug 'digitaltoad/vim-pug', {'commit': 'eb8c6b2'}
Plug 'tpope/vim-markdown', {'commit': 'dcdab0c'}
Plug 'wavded/vim-stylus', {'commit': '9ab38f0'}

"misc
Plug 'morhetz/gruvbox', {'commit': '127c9d1'}  "colorscheme
Plug 'neomake/neomake', {'commit': '75f9f3b'}  "linting
Plug 'tomtom/tcomment_vim', {'commit': 'c982b13'}  "commenting blocks
Plug 'tpope/vim-surround', {'commit': '1a73f60'}  "change surrounding
Plug 'vim-airline/vim-airline', {'commit': '7b9b68f'}  "status bar
"Plug 'sbdchd/neoformat', {'commit': '2111755'}  "auto formatting
"Plug 'prettier/vim-prettier', { 'do': 'yarn install' } "prettier for Vim
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
set textwidth=90
set formatoptions=qrn1

"case insensitive search
set ignorecase
set smartcase

"file types
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.epy set filetype=htmldjango
au BufNewFile,BufRead *.json set filetype=json

"gruvbox theme
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme gruvbox

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
autocmd! BufWritePre,BufEnter * Neomake  "neomake: run on save

"neomake makers for different languages
let g:neomake_go_enabled_makers = ['go']
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
let g:neomake_javascript_enabled_makers = []
let g:neomake_jsx_enabled_makers = []

"neomake with locally-installed (node_modules) eslint/flow
if executable('eslint')
  let g:neomake_javascript_enabled_makers += ['eslint']
  let g:neomake_jsx_enabled_makers += ['eslint']
endif
if executable('flow')
  let g:neomake_javascript_enabled_makers += ['flow']
  let g:neomake_jsx_enabled_makers += ['flow']
endif

"neoformat: format javascript on save
"autocmd BufWritePre *.js Neoformat
"uncomment for neoformat. Needs love for eslint reading?

"netrw, but with NERDtree feels?
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 5
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

"automatically add end braces
inoremap <CR> <C-R>=CleverBrace()<CR>
function! CleverBrace()
  if strpart(getline('.'), col('.') - 2, 1) =~ '{'
    return "\<CR>}\<ESC>O"
  else
    return "\<CR>"
endfunction
