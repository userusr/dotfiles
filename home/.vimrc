" Vim 9.1+, macOS/Linux. Установка и клавиши: docs/vim.md.
" Перечитать конфиг: :source $MYVIMRC

" === Инициализация и локальные возможности ===
set nocompatible
let mapleader = ','
let maplocalleader = '\'
let g:dotfiles_vim_dir = get(g:, 'dotfiles_vim_dir', expand('~/.vim'))
let g:dotfiles_vim_state_dir = get(g:, 'dotfiles_vim_state_dir', g:dotfiles_vim_dir . '/state')
let g:dotfiles_vim_tools_dir = get(g:, 'dotfiles_vim_tools_dir', expand('~/.local/share/vim-tools'))

" Не добавлять runtimepath повторно при :source. Экранировать пробелы и запятые.
let s:runtime = escape(g:dotfiles_vim_dir, ',\')
let s:after = escape(g:dotfiles_vim_dir . '/after', ',\')
if stridx(',' . &runtimepath . ',', ',' . s:runtime . ',') < 0
  let &runtimepath = s:runtime . ',' . &runtimepath
endif
if stridx(',' . &runtimepath . ',', ',' . s:after . ',') < 0
  let &runtimepath .= ',' . s:after
endif
if filereadable(g:dotfiles_vim_dir . '/local.vim')
  execute 'source ' . fnameescape(g:dotfiles_vim_dir . '/local.vim')
endif

" === Текст, поиск, окна и системный буфер ===
set encoding=utf-8
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set autoread hidden
set relativenumber colorcolumn=80 cursorline
set splitright splitbelow
set ignorecase hlsearch incsearch
set pumheight=10 wildmenu
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
let &fillchars = 'vert: '
set backspace=indent,eol,start
set nowrap foldenable foldmethod=indent foldlevelstart=99
set spelllang=en,ru
set tags=./tags;
if has('keymap')
  set keymap=russian-jcukenwin iminsert=0 imsearch=0
endif
if has('clipboard')
  set clipboard=unnamedplus,unnamed
endif
if exists('+termguicolors')
  set termguicolors
endif

" === Undo, backup и swap: вне проектов, с закрытыми правами ===
for s:directory in ['undo', 'backup', 'swap']
  let s:state_path = g:dotfiles_vim_state_dir . '/' . s:directory
  if !isdirectory(s:state_path)
    call mkdir(s:state_path, 'p', 0700)
  endif
endfor
let &undodir = g:dotfiles_vim_state_dir . '/undo//'
let &backupdir = g:dotfiles_vim_state_dir . '/backup//'
let &directory = g:dotfiles_vim_state_dir . '/swap//'
set undofile backup backupcopy=yes

" === Настройки плагинов до их загрузки ===
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeChDirMode = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeIgnore = ['\.pyc$', '\.swp$', '\~$']
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:tagbar_sort = 0
let g:tagbar_width = 40
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_shade = 0
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsListSnippets = '<C-l>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
if isdirectory(expand('~/.vim-snippets'))
  call add(g:UltiSnipsSnippetDirectories, expand('~/.vim-snippets'))
endif
let g:airline_theme = 'zenburn'
let g:airline_powerline_fonts = get(g:, 'airline_powerline_fonts', 0)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tagbar#enabled = 0
let g:tex_flavor = 'latex'

" ALE: один набор инструментов; исправления только по явной команде.
let g:ale_linters_explicit = 1
let g:ale_linters = {'sh': ['shellcheck'], 'yaml': ['yamllint']}
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:ale_set_loclist = 1
let g:ale_open_list = 0
let g:ale_python_pyright_executable = g:dotfiles_vim_tools_dir . '/bin/basedpyright-langserver'
let g:ale_python_pyright_use_global = 1
let g:ale_python_pyright_config = {
\ 'basedpyright': {'analysis': {'typeCheckingMode': 'standard'}}
\ }
let g:ale_python_ruff_executable = g:dotfiles_vim_tools_dir . '/bin/ruff'
let g:ale_python_ruff_format_executable = g:ale_python_ruff_executable

" === Плагины: скачивание выполняется только scripts/install_vim ===
if filereadable(g:dotfiles_vim_dir . '/autoload/plug.vim')
  call plug#begin(g:dotfiles_vim_dir . '/plugged')
  " Навигация и поиск; бинарник fzf устанавливает пакетный менеджер.
  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'easymotion/vim-easymotion'
  " Редактирование и история.
  Plug 'preservim/nerdcommenter'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'godlygeek/tabular'
  Plug 'mbbill/undotree'
  if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
  endif
  " Git и диагностика.
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'dense-analysis/ale'
  " Языки и внешний вид.
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'jnurmine/Zenburn'
  " Дополнительные языки включаются в ~/.vim/local.vim.
  if get(g:, 'dotfiles_vim_latex', 0)
    Plug 'lervag/vimtex', { 'tag': 'v2.18' }
  endif
  if get(g:, 'dotfiles_vim_perl', 0)
    Plug 'vim-perl/vim-perl'
    Plug 'yko/mojo.vim'
  endif
  if get(g:, 'dotfiles_vim_puppet', 0)
    Plug 'rodjek/vim-puppet'
  endif
  call plug#end()
elseif !get(g:, 'dotfiles_vim_bootstrap_notice', 0)
  echom 'Плагины Vim не установлены. Из dotfiles запустите: bash scripts/install_vim'
  let g:dotfiles_vim_bootstrap_notice = 1
endif
filetype plugin indent on
syntax enable

" === Общие клавиши: только явно указанные режимы ===
" Сохранить все буферы; перемещение по открытым файлам.
nnoremap <silent> <leader>w :wall<CR>
nnoremap <silent> H :bprevious<CR>
nnoremap <silent> L :bnext<CR>
" Поиск с центрированием; перемещение по визуальным строкам.
nnoremap n nzz
nnoremap N Nzz
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
xnoremap j gj
xnoremap k gk
xnoremap gj j
xnoremap gk k
" Окна; историю переходов оставить на Ctrl+O/I, Tab не переназначать.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Сохранить привычное отключение случайного изменения чисел.
nnoremap <C-a> <Nop>
nnoremap <C-x> <Nop>
xnoremap <C-a> <Nop>
xnoremap <C-x> <Nop>
if has('keymap')
  inoremap <leader>r <C-^>
endif

" === Клавиши установленных плагинов ===
" Без autoload/dotfiles.vim остаётся доступно обычное редактирование.
if !empty(globpath(&runtimepath, 'autoload/dotfiles.vim'))
  if dotfiles#has_plugin('nerdtree')
    nnoremap <silent> <leader>e :NERDTreeFocus<CR>
    nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
    nnoremap <silent> <leader>ts :NERDTreeToggle<CR>
    nnoremap <silent> <F1> :NERDTreeToggle<CR>
  endif
  if dotfiles#has_plugin('tagbar')
    nnoremap <silent> <leader>tb :TagbarToggle<CR>
  endif
  if dotfiles#has_plugin('undotree')
    nnoremap <silent> <leader>ut :UndotreeToggle<CR>:UndotreeFocus<CR>
  endif
  if dotfiles#has_plugin('fzf.vim')
    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>to :Buffers<CR>
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>/ :Lines<CR>
    nnoremap <silent> <leader>? :Rg<CR>
    nnoremap <silent> <leader>s :Rg<CR>
    nnoremap <silent> <leader>gc :Commits<CR>
    nnoremap <silent> <leader>gf :call dotfiles#search(expand('<cword>'))<CR>
    xnoremap <silent> <leader>gf :<C-U>call dotfiles#search_visual()<CR>
    if dotfiles#has_plugin('ultisnips')
      nnoremap <silent> <leader>is :Snippets<CR>
    endif
  endif
  if dotfiles#has_plugin('ultisnips')
    nnoremap <silent> <leader>ie :UltiSnipsEdit<CR>
  endif
  if dotfiles#has_plugin('vim-fugitive')
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>tgv :Git<CR>
  endif
  if dotfiles#has_plugin('vim-easymotion')
    nmap s <Plug>(easymotion-overwin-f2)
  endif
  if dotfiles#has_plugin('nerdcommenter')
    nmap <C-_> <Plug>NERDCommenterToggle
    xmap <C-_> <Plug>NERDCommenterToggle
  endif
  if dotfiles#has_plugin('ale')
    " ALEFix асинхронный: сохранить после завершения через ,w.
    nnoremap <silent> <leader>df :ALEFix<CR>
    nnoremap <silent> <leader>dc :ALELint<CR>
    nmap <silent> [d <Plug>(ale_previous_wrap)
    nmap <silent> ]d <Plug>(ale_next_wrap)
  endif
endif

" === Тема: запуск без загруженных плагинов тоже работает ===
set background=dark
if !empty(globpath(&runtimepath, 'colors/zenburn.vim'))
  colorscheme zenburn
else
  colorscheme default
endif
