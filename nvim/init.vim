"
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'ervandew/supertab'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
call plug#end()

set number
set list
set ignorecase
set smartcase
set incsearch
set hlsearch
set mouse=a
set listchars=tab:▸\ ,trail:•
set expandtab tabstop=2 shiftwidth=2
set ttimeoutlen=10
set backspace=indent,eol,start
set noshowmode

" NEOVIM
"""""""""""""""""""""""""""
let g:python_host_prog = $HOME.'/.local/share/virtualenvs/neovim2-jjLPz5fr/bin/python'
let g:python3_host_prog = $HOME.'/.local/share/virtualenvs/neovim3-_KFLpCk5/bin/python'
" LIGHTLINE
"""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }

" ONEDARK
"""""""""""""""""""""""""""
let g:onedark_termcolors=16
colorscheme onedark

" ALE
"""""""""""""""""""""""""""
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
      \  'javascript': ['eslint'],
      \  'python': ['flake8', 'mypy'],
      \ }

" DEOPLETE
"""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

" JEDI
"""""""""""""""""""""""""""
let g:jedi#completions_enabled = 0

" SUPERTAB
"""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-u>"
autocmd FileType *
      \ if &omnifunc != '' |
      \   call SuperTabChain(&omnifunc, "<c-p>") |
      \   call SuperTabSetDefaultCompletionType("context") |
      \ endif

" JSX
"""""""""""""""""""""""""""
let g:jsx_ext_required = 0

" LIMELIGHT
"""""""""""""""""""""""""""
let g:limelight_conceal_ctermfg = 'darkgray'

" GOYO
"""""""""""""""""""""""""""
function! s:goyo_enter()
  set spell noci nosi noai nolist noshowmode noshowcmd
  Limelight
endfunction

function! s:goyo_leave()
  set nospell ci si ai list showmode showcmd
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" KEYBINDINGS
"""""""""""""""""""""""""""
let mapleader = " "
let maplocalleader = " "

" Edit alternate (previous) file. Used mostly for toggling
map <leader><leader> <C-^>

" Gracefully handle holding shift too long after : for common commands
cabbrev W w
cabbrev Q q
cabbrev Wq wq
cabbrev Tabe tabe
cabbrev Tabc tabc

" apply smartcase to * and # search
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

"set pastetoggle keybinding
set pastetoggle=<F2>

" Make Y consistent with D and C
map Y           y$

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/

" Move between screens
map <leader>w   ^Ww
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk
nmap <C-j>      <C-w>j
nmap <C-k>      <C-w>k
nmap <C-h>      <C-w>h
nmap <C-l>      <C-w>l

" Reload init.vim
map <leader>rv  :source ~/.config/nvim/init.vim<CR>

" Auto-indent whole file
nmap <leader>=  gg=G``
map <silent> <F7> gg=G`` :delmarks z<CR>:echo "Reformatted."<CR>

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" Open and close the quickfix window
map <leader>qo  :copen<CR>
map <leader>qc  :cclose<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

" Git blame
map <leader>g   :Gblame<CR>

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" Copy current file path to system pasteboard
map <leader>cp :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>cpl :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>

" Disable middle mouse button, F1
map <MiddleMouse>   <Nop>
imap <MiddleMouse>  <Nop>
map <F1>            <Nop>
imap <F1>           <Nop>

" save on ESC
inoremap <Esc> <Esc>:w<CR>

" Recalculate diff when it gets messed up.
nmap du :diffupdate<CR>

" Press Space to turn off highlighting and clear any message already
" displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" FZF
map <Leader>f :Files<CR>
map <Leader>a :Ag<CR>

" Vimux
map <Leader>vr :VimuxRunCommand("
map <Leader>vd :VimuxRunCommandInDir("
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>v1 :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vs :VimuxStopRunner<CR>
map <Leader>vc :VimuxClearRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" bundler.vim
map <Leader>bo :Bopen<CR>
map <Leader>bs :Bsplit<CR>
map <Leader>bv :Bvsplit<CR>
