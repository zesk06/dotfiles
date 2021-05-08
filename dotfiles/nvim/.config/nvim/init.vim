" GENERAL OPTIONS {{{

set background=dark
set backspace=indent,eol,start
set cmdheight=2
set confirm
set hidden
set hlsearch
set ignorecase
set laststatus=2
set mouse=
set nostartofline
set notimeout ttimeout ttimeoutlen=200
set nowrap
set number relativenumber
set path+=**
set ruler
set showcmd
set smartcase
set t_vb=
set tabstop=4 shiftwidth=4 expandtab
set visualbell
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
set wildmenu

" BACKUP and UNDO
set backupdir=~/tmp/vim/backup
set directory=~/tmp/vim/backup " Don't clutter my dir with temp *.swp *.swo files
if has("persistent_undo")
    set undodir=~/tmp/vim/undo
    set undofile
endif

" }}}

" THEMING {{{
syntax on

" But use dark theming because we love to have black background
" Make it more obvious which paren I'm on
hi MatchParen cterm=underline ctermbg=black ctermfg=yellow

" }}}


" Grep: Using AG / the silver searcher {{{
" on va utiliser ag pour grepper
if executable('ag')
    " use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ node_modules\ --ignore\ .git
endif

" }}}
let g:python3_host_prog="~/.virtualenvs/neovim/bin/python3"

" PLUG: NerdTree {{{
" Map <C-n> to toggle nerdtree
" use C-w w to switch between tree and window
nnoremap <C-n> :NERDTreeToggle<CR> 
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1
" }}}

" PLUG: airline {{{
let g:airline_section_b = 'b%{bufnr("%")}'
let g:airline_section_x = '' " filetype
let g:airline_section_y = '' " fileencoding
let g:airline_section_z = '%l:%c' " position
" }}}


" PLUG: syntastic {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_ignore_errors = ["proprietary attribute"]
let g:syntastic_disabled_filetypes=["html"]
" }}}

" PLUG: json-vim customization {{{
" disabling quote concealing
" Ca consiste a cacher les " dans le json
" Perso, j'aime pas bien
let g:vim_json_syntax_conceal = 0
" }}}

" PLUG: COC {{{
" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
" nmap gr <Plug>(coc-references)
nmap gr <Plug>(coc-rename)
" }}}

" PLUG: vimwiki {{{
  let g:vimwiki_list = [{'path': '~/.dotfiles/wiki', 'syntax': 'markdown', 'ext': '.md'}]
" }}}
"

" PLUG: UltiSnips {{{
" Trigger configuration. 
" We will use Shift-Tab since <tab> is used by supertab
let g:UltiSnipsExpandTrigger="<S-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/ultisnips/"]
let g:UltiSnipsEditSplit="vertical"
" }}}

" MAPPINGS {{{
"------------------------------------------------------------
" change leadermap
let mapleader= " "
let maplocalleader = " "

" editing/sourcing .vimrc
noremap <leader>cd :lcd %:h<CR>
noremap <leader>ev :edit $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>e  :e <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
noremap <leader>w  :w <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
nnoremap <leader>o :execute "rightbelow vsplit " . bufname('#')<CR>
nnoremap / /\v
" surrounding current word with " or ' or (
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
vnoremap <leader>( <esc>`<i(<esc>`>la)<esc>
inoremap jk <esc>
tnoremap <esc> <C-\><C-n>
" on vire les bracket paste
inoremap [200~ <NOP>
inoremap [201~ <NOP>

" Le comeback du Ctrl+S pour sauver le fichier
function! SaveMe()
    execute "w"
    echom "fichier sauvé: 🐍".expand("%h")
endfunction

inoremap <C-S> <ESC>:call SaveMe()<CR>
nnoremap <C-S> :call SaveMe()<CR>
nnoremap <C-P> :FZF! --reverse<CR>

nnoremap <localleader>d :e #<CR>:bd #<CR>

" Map K to grep the word under the cursor and open quickfix window
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Map <localleader>g to grep word under cursor as tutorialed in
" learnvimscriptthehardway
" grep! : launch grep but does not goes to first result
" silent: void the grep's output

nnoremap <localleader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>

" quick move in quickfix window
nnoremap <localleader>n :cnext<CR>
nnoremap <localleader>p :cprev<CR>
nnoremap <localleader>d :e#<BAR>d#<CR>

"
" Map <space><space> to close quickfix window
nnoremap <space><space> :ccl<BAR>nohl<BAR>lcl<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
nnoremap Y y$
vnoremap Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Go to next buffer
noremap gn :bn<CR>

" ease window move
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" really, just don't
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

" operator pending mappings
onoremap in(	:<c-u>normal! f(vi(<cr>
onoremap in{	:<c-u>normal! f{vir<cr>
onoremap in[	:<c-u>normal! f[vi[<cr>
onoremap in"	:<c-u>normal! f"vi"<cr>
onoremap in'	:<c-u>normal! f'vi'<cr>

" abbrv
" replace %% with current file parent dir in command
cabbr <expr> %% expand('%:p:h')
" }}}

" python files -------------------{{{

function! BlackAndResetCursor ()
    let cursor_pos = getpos('.')
    :%! black -q -
    call setpos('.', cursor_pos)
endfunction

function! IsortAndResetCursor ()
    let cursor_pos = getpos('.')
    :%! isort --stdout --force-single-line-import -
    call setpos('.', cursor_pos)
endfunction

function! RunPython ()
    :echo "Launching ".expand("%")
    :!python shellescape(@%, 1)
endfunction


augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <localleader>c 0i#<esc>
    autocmd FileType python nnoremap <localleader>f :call BlackAndResetCursor()<cr>:call IsortAndResetCursor()<cr>
    autocmd FileType python nnoremap <localleader>b :w \| :!python %:p<cr>
    autocmd FileType python nnoremap <localleader>t :w \| :!py.test %:p<cr>
    " autocmd FileType python vnoremap <localleader>r :'<,'>write !python <cr>
    " File options
    autocmd FileType python set number relativenumber
    autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType python set cc=88
    autocmd FileType python set foldmethod=indent foldlevel=50

    " some abbrev I
    autocmd FileType python :iabbrev <buffer> ipdb import ipdb; ipdb.set_trace()<cr>
    autocmd FileType python :iabbrev <buffer> thisdir from path import Path<cr># pylint: disable=C0103<cr>THIS_DIR = Path(__file__).abspath().dirname()<cr>
augroup END
" }}}

" markdown files -------------------{{{
augroup filetype_markdown
    autocmd!
    " File options
    autocmd FileType markdown set number relativenumber
    autocmd FileType markdown set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType markdown set conceallevel=0
    autocmd FileType markdown set cc=80
augroup END
" }}}

" yaml files ---------------------{{{
augroup filetype_yaml
    autocmd!
    autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType yaml set autoindent
    autocmd FileType yaml set cc=80
augroup END
" }}}

" html files ---------------------{{{
function! PrettierAndResetCursor (parser)
  let cursor_pos = getpos('.')
  execute "%!prettier --parser ".a:parser." --stdin"
  call setpos('.', cursor_pos)
endfunction

augroup filetype_html
    autocmd!
    autocmd FileType html,jinja.html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType html,jinja.html set nowrap
    autocmd FileType html,jinja.html set formatprg=prettier\ --stdin\ --parser\ html
    autocmd FileType html,jinja.html nnoremap <leader>f :call PrettierAndResetCursor("html")<cr>
    autocmd FileType html,jinja.html :SyntasticToggleMode
augroup END
" }}}

" javascript files ---------------------{{{

augroup filetype_javascript
    autocmd!
    autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType javascript set nowrap
    autocmd FileType javascript set formatprg=prettier\ --stdin\ --parser\ flow
    autocmd FileType javascript nnoremap <leader>f :call PrettierAndResetCursor("flow")<cr>
augroup END
" }}}

" vim files ---------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType vim set foldlevel=50 foldmethod=marker
augroup END
" }}}

" json files ---------------------{{{
augroup filetype_json
    autocmd!
    " reformat file using python json tool
    autocmd FileType json nnoremap <leader>f :%!python -m json.tool<cr>
    autocmd BufRead,BufNewFile *.json setfiletype json
augroup END
" }}}


" """"""""""""""""""""""""""""""""""""
" VIM-PLUG
" https://github.com/junegunn/vim-plug
" """"""""""""""""""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'chrisbra/unicode.vim'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'gruvbox-community/gruvbox'
Plug 'joom/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leshill/vim-json'
Plug 'mbbill/undotree'
Plug 'mechatroner/rainbow_csv'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vimwiki/vimwiki'
Plug 'yggdroot/indentline'

if has('nvim')
  Plug 'neomake/neomake'
else
  " vim ?
endif
" Initialize plugin system
call plug#end()

"must be after plugin
colorscheme gruvbox 

" Permet d'aller au tag correspondant avec %
runtime macros/matchit.vim

nnoremap <leader>q :call QuickFixToggle()<CR>
let g:quickfix_is_open = 0
function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        " on tape Ctrl+w plusieurs fois pour retourner à la window precédente
        execute g:quickfix_return_to_window . "wincmd w"
    else
        " on sauve le numero de fenetre courante
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

