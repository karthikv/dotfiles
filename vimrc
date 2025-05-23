call plug#begin()

"languages
Plug 'vim-ruby/vim-ruby', {'commit': '71f5df7'}
Plug 'fatih/vim-go', {'commit': 'a64d097'}
Plug 'pangloss/vim-javascript', {'commit': '871ab29'}
Plug 'leafgarland/typescript-vim', {'commit': '31ede5a'}
Plug 'MaxMEllon/vim-jsx-pretty', {'commit': '77c2063'}
Plug 'ElmCast/elm-vim', {'commit': '16a9a38'}
Plug 'neovimhaskell/haskell-vim', {'commit': '1862418'}
Plug 'elixir-lang/vim-elixir', {'commit': '1cfd5ab'}
Plug 'rust-lang/rust.vim', {'commit': 'e651851'}
Plug 'zah/nim.vim', {'commit': 'dcf2579'}
Plug 'clojure-vim/clojure.vim', {'commit': '06196d8'}
Plug 'Olical/conjure', {'commit': '6d2bc7f'}
Plug 'luochen1990/rainbow', {'commit': '76ca1a2'}
Plug 'nvim-treesitter/nvim-treesitter', {'commit': '5a2ff8b', 'do': ':TSUpdate'}
Plug '~/Active/par-vim'

"config/templating/extensions
Plug 'elzr/vim-json', {'commit': 'f5e3181'}
Plug 'hashivim/vim-terraform', {'commit': 'bfc6ef2'}
Plug 'digitaltoad/vim-pug', {'commit': 'eb8c6b2'}
Plug 'tpope/vim-markdown', {'commit': 'dcdab0c'}
Plug 'wavded/vim-stylus', {'commit': '9ab38f0'}
Plug 'slim-template/vim-slim', {'commit': 'b19d372'}

"misc
Plug 'jeffkreeftmeijer/vim-dim', {'commit': '00d1b3b'}  "theme
" Plug 'dense-analysis/ale', {'commit': '41ff80d'}  "linting
Plug 'dense-analysis/ale', {'commit': '9546821'}  "linting
Plug 'tomtom/tcomment_vim', {'commit': 'c982b13'}  "commenting blocks
Plug 'tpope/vim-surround', {'commit': '1a73f60'}  "change surrounding
Plug 'vim-airline/vim-airline', {'commit': '3d9071e'}  "status bar
Plug 'vim-airline/vim-airline-themes', {'commit': 'e6f2332'}  "status bar
Plug 'karthikv/tradeship-vim', {'commit': '849651d'}  "auto imports
Plug 'christoomey/vim-tmux-navigator', {'commit': '9f7d158'}  "tmux movement

"file searching
Plug 'junegunn/fzf', {
      \  'commit': 'b2ecb63',
      \  'dir': '~/.fzf',
      \  'do': './install --all'
      \}
Plug 'junegunn/fzf.vim', {'commit': '95f025e'}

call plug#end()

"enable filetypes (already done by vim-plug, but in case that changes)
filetype plugin indent on
syntax enable
syntax sync minlines=10000  "so highlighting doesn't break in large files

"fix typescript syntax in nvim - see https://github.com/leafgarland/typescript-vim/issues/184
hi link typescriptReserved Keyword
hi link typescriptParens Operator
hi link typescriptNull Type

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
set showmode  "show current mode
set completeopt=menu,menuone,preview,noselect,noinsert  "code completion
set wildmenu  "more useful command-line completion
set wildmode=list:longest  "auto-completion menu
set mouse=  "mouse selection shouldn't change vim mode; allows cmd + C to work
set noshowmode  "mode shown in airline
set shortmess+=c  "don't show omnicomplete messages like 'match 1 of 19'
set nomodeline  "disable modeline for security; see https://git.io/fju2K

"remove esc delay
set timeoutlen=1000
set ttimeoutlen=0

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

"backups
set writebackup
set nobackup
set backupcopy=yes  "to ensure file watching works

"file types
augroup Custom
  au!
  au BufNewFile,BufRead *.less set filetype=less
  au BufNewFile,BufRead *.epy set filetype=htmldjango
  au BufNewFile,BufRead *.json set filetype=json
  au BufNewFile,BufRead *.ts set filetype=typescript
  au BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  au FileType erlang setlocal indentexpr=
  au FileType typescript nmap <Leader>i :call TSImportReference()<CR>
  au FileType typescript.tsx nmap <Leader>i :call TSImportReference()<CR>
augroup END

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"theme
colorscheme dim
set notermguicolors
hi! Identifier ctermfg=blue
hi! PreProc ctermfg=magenta
hi! Special ctermfg=magenta
hi! Constant ctermfg=yellow
hi! Type ctermfg=green
hi! Statement ctermfg=magenta
hi! Conditional ctermfg=blue

hi! SpellBad ctermfg=white ctermbg=red
hi! def link Error SpellBad
hi! SpellCap ctermfg=white ctermbg=brown
hi! def link Todo SpellCap

hi! def link tsxTagName Function
hi! def link tsxCloseString Function
hi! String ctermfg=red
hi! Keyword ctermfg=darkcyan
" hi! Label ctermfg=darkgreen (for 'async' keyword)

"completion
imap <C-j> <C-n>
imap <C-k> <C-p>

"easier window navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

"helpful shortcuts
let mapleader='s'
let maplocalleader=','
nmap <Leader>l :vsplit<CR><M-l>
nmap <Leader>j :split<CR>
nmap <Leader>r :redraw!<CR>
nmap <Leader>s :set spell! spell?<CR>
nmap <Leader>h :set hls! hls?<CR>
nmap <Leader>2 :set ts=2 sts=2 sw=2 et<CR>
nmap <Leader>4 :set ts=4 sts=4 sw=4 et<CR>
nmap <Leader>8 :set ts=8 sts=8 sw=8 et<CR>
nmap <Leader>p :set invpaste paste?<CR>
nmap <Leader>v :source %<CR>
nmap <Leader>t :terminal<CR>
nmap <Leader>d :ALEDetail<CR>
nmap <Leader>e :ALEHover<CR>
nmap <Leader>g :ALEGoToDefinition<CR>
nmap <Leader>n :ALERename<CR>
nmap <Leader>; :ALEReset<CR>:ALEDisable<CR>:ALEEnable<CR>
nmap <Leader>x :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
      \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
      \ . ">"<CR>

"file searching
nmap <C-p> :Files<CR>

"search for text under cursor
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"spelling corrections
iab teh the
iab Teh The

let g:javascript_plugin_flow = 1  "vim-javascript: enable flow highlighting
let g:jsx_ext_required = 0  "vim-jsx: make .jsx extension not requried
let g:go_fmt_fail_silently = 1  "vim-go: don't complain if fmt fails
let g:go_fmt_command = 'goimports'  "vim-go: use goimports as fmt tool
let g:elm_format_autosave = 1  "elm-vim: format on save

let g:airline_theme = 'term'
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
      \  'javascript': [],
      \  'typescript': ['tsserver'],
      \  'ruby': ['rubocop'],
      \  'rust': ['rls'],
      \}
let g:ale_fixers = {
      \  'javascript': ['prettier'],
      \  'typescript': ['prettier'],
      \  'rust': ['rustfmt'],
      \  'python': ['ruff_format'],
      \  'elixir': ['mix_format'],
      \}
let g:ale_rust_rls_toolchain = 'nightly-2019-02-08'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

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

"typescript auto imports
function! s:TSHandleImportResponse(file, conn_id, response) abort
  let l:body = get(a:response, 'body', v:null)
  if l:body is v:null
    return 0
  endif

  let l:fix = get(l:body, 0, v:null)
  if l:fix is v:null || get(l:fix, 'fixName', '') isnot# 'import'
    return 0
  endif

  for l:change in l:fix.changes
    if l:change.fileName is# a:file
      "applying changes in reverse order appears to give the correct output.
      "otherwise, changes overwrite each other in a way that's incorrect.
      for l:textChange in reverse(l:change.textChanges)
        let l:startLine = getline(l:textChange.start.line)
        let l:endLine = getline(l:textChange.end.line)

        if l:textChange.start.offset == 1
          let l:beforeText = ""
        else
          let l:beforeText = l:startLine[:l:textChange.start.offset - 2]
        endif

        let l:newText = l:beforeText . l:textChange.newText .
              \l:endLine[l:textChange.end.offset - 1:]
        if l:textChange.start == l:textChange.end
          let l:newText .= "\n"
        end

        let l:offset = 0
        for line in split(l:newText, '\n')
          let l:lineNo = l:textChange.start.line + l:offset
          let l:offset += 1

          if l:lineNo > l:textChange.end.line
            call append(l:lineNo - 1, line)
          else
            call setline(l:lineNo, line)
          endif
        endfor
      endfor
    endif
  endfor
endfunction

function! s:TSImportOnReady(line, column, file, linter, lsp_details) abort
  if a:linter.lsp isnot# 'tsserver'
    return
  endif

  let l:id = a:lsp_details.connection_id
  let l:Callback = function('s:TSHandleImportResponse', [a:file])
  call ale#lsp#RegisterCallback(l:id, l:Callback)

  let l:message = [0, 'ts@getCodeFixes', {
        \   'startLine': a:line,
        \   'startOffset': a:column,
        \   'endLine': a:line,
        \   'endOffset': a:column,
        \   'file': a:file,
        \   'errorCodes': [2304],
        \}]

  call ale#lsp#Send(l:id, l:message)
endfunction

function! TSImportReference() abort
  for l:linter in ale#linter#Get(&filetype)
    if l:linter.lsp is# 'tsserver'
      break
    endif
  endfor

  let l:buffer = bufnr('')
  let [l:line, l:column] = getcurpos()[1:2]
  let l:file = expand('#' . l:buffer . ':p')

  let l:Callback = function('s:TSImportOnReady', [l:line, l:column, l:file])
  let l:lsp_details = ale#lsp_linter#StartLSP(l:buffer, l:linter, l:Callback)
endfunction
