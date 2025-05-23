" Vungle.vim
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Reload .vimrc file
" % - alias for current file name
"    :source %
"    :source $MYVMRC
"
" Docs
" https://code.djangoproject.com/wiki/UsingVimWithDjango
"
" Install all packages
" cat .vimrc | grep -P '^"\s+sudo\s+apt' | sed 's/^\"\s\+sudo\s\+apt\s\+install\s\+\(.*\)$/\1/g' | xargs apt install -y
"
" Install plug
" https://github.com/junegunn/vim-plug
"
" For NeoVIM
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" The NERDTree is a file system explorer for the Vim editor. Using this plugin,
" users can visually browse complex directory hierarchies, quickly open files
" for reading or editing, and perform basic file system operations.
Plug 'scrooloose/nerdtree'

" Comment functions so powerful—no comment necessary.
Plug 'scrooloose/nerdcommenter'

" Tagbar is a Vim plugin that provides an easy way to browse the tags of the
" current file and get an overview of its structure. It does this by creating
" a sidebar that displays the ctags-generated tags of the current file,
" ordered by their scope.  This means that for example methods in C++ are
" displayed under the class they are defined in.
Plug 'majutsushi/tagbar'

" Vim vim has long been my favorite text editor and combined with [Exuberant
" Ctags] exctags it has the potential to provide most of what I expect from an
" [integrated development environment] ide. Exuberant Ctags is the latest
" incarnation of a [family of computer programs] ctags that scan source code
" files to create an index of identifiers (tags) and where they are defined.
" Vim uses this index (a so-called tags file) to enable you to jump to the
" definition of any identifier using the [Control-]] ctrl_mapping mapping.
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

" support for writing LaTeX documents
Plug 'lervag/vimtex'

" sudo apt install build-essential cmake python-dev python3-dev
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py --clang-completer
" Plugin 'valloric/youcompleteme'
" jedi-vim is a VIM binding to the autocompletion library Jedi.
" Completion       <C-Space>
" Goto assignments <leader>g
" Goto definitions <leader>d
" Show Docm        K (shows a popup with assignments)
" Renaming         <leader>r
" Usages           <leader>n (shows all the usages of a name)
" Open module     :Pyimport os (opens the os module)

" sudo apt install python3-jedi
" Plug 'davidhalter/jedi-vim'
" Vim plugin to sort python imports using isort
" You can configure the default mapping for the visual mode sorter, like this:
"   let g:vim_isort_map = '<C-i>'
" Or disable the mapping with this:
"   let g:vim_isort_map = ''
" You can also specify a particular Python version, so if isort is installed
" under Python 3:
"   let g:vim_isort_python_version = 'python3'

" sudo apt install python3-isort python3-setuptools
" Plug 'fisadev/vim-isort'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Run your favorite search tool from Vim, with an enhanced results list.
" The quickfix results window is augmented with these convenience mappings:
" ?    a quick summary of these keys, repeat to close
" o    to open (same as Enter)
" O    to open and close the quickfix window
" go   to preview file, open but maintain focus on ack.vim results
" t    to open in new tab
" T    to open in new tab without moving to it
" h    to open in horizontal split
" H    to open in horizontal split, keeping focus on the results
" v    to open in vertical split
" gv   to open in vertical split, keeping focus on the results
" q    to close the quickfix window
Plug 'mileszs/ack.vim'

" [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)
" help fzf-vim
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" I'm not going to lie to you; fugitive.vim may very well be the best Git
" wrapper of all time. :)
Plug 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the 'gutter' (sign column). It shows
" which lines have been added, modified, or removed. You can also preview,
" stage, and undo individual hunks. The plugin also provides a hunk text
" object.
"
"   jump to next hunk (change): ]c
"   jump to previous hunk (change): [c.
"
"   ic operates on all lines in the current hunk.
"   ac operates on all lines in the current hunk and any trailing empty lines.
"
Plug 'airblade/vim-gitgutter'
" EasyMotion provides a much simpler way to use some motions in vim.
Plug 'easymotion/vim-easymotion'
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and add
" such surroundings in pairs.
Plug 'tpope/vim-surround'
" Format code with one button press (or automatically on save).
Plug 'Chiel92/vim-autoformat'
" ALE (Asynchronous Lint Engine) is a plugin for providing linting in NeoVim
" 0.2.0+ and Vim 8 while you edit your text files.
"   sudo apt install python3-pep8 pylint3 python3-flake8 yamllint
"   sudo apt install python3-pylama python3-gflags python3-mypy
"   sudo apt install python3-pycodestyle
" Plugin 'w0rp/ale'
" Syntastic is a syntax checking plugin for Vim created by Martin Grenfell. It
" runs files through external syntax checkers and displays any resulting errors
" to the user. This can be done on demand, or automatically as files are saved.
" If syntax errors are detected, the user is notified and is happy because they
" didn't have to compile their code or execute their script to find them.
"   sudo apt install python3-pep8 pylint3 python3-flake8
"   sudo apt install python3-pylama python3-gflags python3-pydocstyle python3-mypy
Plug 'scrooloose/syntastic'
" There are mappings which are simply short normal mode aliases for commonly
" used ex commands. ]q is :cnext. [q is :cprevious. ]a is :next. [b is
" :bprevious. See the documentation for the full set of 20 mappings and
" mnemonics. All of them take a count.
"
" There are linewise mappings. [<Space> and ]<Space> add newlines before and
" after the cursor line. [e and ]e exchange the current line with the one above
" or below it.
"
" There are mappings for toggling options. [os, ]os, and =os perform :set spell,
" :set nospell, and :set invspell, respectively. There's also l (list), n
" (number), w (wrap), x (cursorline cursorcolumn), and several others, plus
" mappings to help alleviate the set paste dance. Consult the documentation.
"
" There are mappings for encoding and decoding. [x and ]x encode and decode XML
" (and HTML). [u and ]u encode and decode URLs. [y and ]y do C String style
" escaping.
"
" And in the miscellaneous category, there's [f and ]f to go to the
" next/previous file in the directory, and [n and ]n to jump between SCM
" conflict markers.
Plug 'tpope/vim-unimpaired'
" If you've ever tried using the . command after a plugin map, you were likely
" disappointed to discover it only repeated the last native command inside that
" map, rather than the map as a whole. That disappointment ends today.
" Repeat.vim remaps . in a way that plugins can tap into it.
Plug 'tpope/vim-repeat'
" This plugin causes all trailing whitespace characters (see Supported
" Whitespace Characters below) to be highlighted. Whitespace for the current
" line will not be highlighted while in insert mode. It is possible to disable
" current line highlighting while in other modes as well (see options below). A
" helper function :StripWhitespace is also provided to make whitespace cleaning
" painless.
Plug 'ntpeters/vim-better-whitespace'
" sudo apt install fonts-powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Sometimes, it's useful to line up text. Naturally, it's nicer to have the
" computer do this for you, since aligning things by hand quickly becomes
" unpleasant. While there are other plugins for aligning text, the ones I've
" tried are either impossibly difficult to understand and use, or too
" simplistic to handle complicated tasks. This plugin aims to make the easy
" things easy and the hard things possible, without providing an unnecessarily
" obtuse interface. It's still a work in progress, and criticisms are welcome.
" See Aligning Text with Tabular.vim for a screencast that shows how
" Tabular.vim works.
" See doc/Tabular.txt for detailed documentation.
Plug 'godlygeek/tabular'
" puppet
Plug 'rodjek/vim-puppet'
" YAML
" https://stackoverflow.com/questions/19030290/syntax-highlighting-causes-terrible-lag-in-vim
" Plug 'stephpy/vim-yaml'
" javascript
Plug 'pangloss/vim-javascript'
" html
Plug 'othree/html5.vim'
" Docker
Plug 'ekalinin/dockerfile.vim'
" perl
Plug 'vim-perl/vim-perl'
Plug 'yko/mojo.vim'
" Plug 'perl-support.vim'
" css
Plug 'mtscout6/vim-tagbar-css'
" python
" $ sudo apt install python-autopep8
Plug 'tell-k/vim-autopep8'
" $ sudo apt install python3-yapf
Plug 'google/yapf', { 'rtp': 'plugins/vim'  }
" Black is the uncompromising Python code formatter
" $ sudo apt install python3-venv
Plug 'psf/black'
" The plug-in visualizes undo history and makes it easier to browse and switch
" between different undo branches.
Plug 'mbbill/undotree'
" colors
Plug 'chriskempson/base16-vim'
Plug 'damage220/solas.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'mhartington/oceanic-next'
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'  " colorscheme gruvbox
Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'
"
" Plugins to see
"
" endwise.vim
" This is a simple plugin that helps to end certain structures automatically.
" In Ruby, this means adding end after if, do, def and several other keywords.
" In Vimscript, this amounts to appropriately adding endfunction, endif, etc.
" There's also Bourne shell, Z shell, VB (don't ask), C/C++ preprocessor,
" Lua, Elixir, Haskell, Objective-C, Matlab, Crystal and Jinja templates support.
" Plugin 'tpope/vim-endwise.git'
"
" vim-polyglot
" A collection of language packs for Vim.
" Plugin 'sheerun/vim-polyglot'

" call vundle#end()

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" For JS/JSX
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()
filetype plugin indent on

" $ wget -P ~/.vim/spell/ ftp://ftp.vim.org/pub/vim/runtime/spell/en.*
" $ wget -P ~/.vim/spell/ ftp://ftp.vim.org/pub/vim/runtime/spell/ru.*
set spelllang=en,ru
" Number of spaces that a <Tab> in the file counts for.
set tabstop=4
" Use the appropriate number of spaces to insert a <Tab>.
set expandtab
" Number of spaces that a <Tab> counts for while performing editing
" operations, like inserting a <Tab> or using <BS>.
set softtabstop=4
" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4
" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread
" Copy indent from current line when starting a new line.
set autoindent
" Do smart autoindenting when starting a new line.
set smartindent
" Show the line number relative to the line with the cursor in front of each line.
set relativenumber
" When the keyboard doesn't produce the characters you want to enter in your
" text, you can use the 'keymap' option.  This will translate one or more
" (English) characters to another (non-English) character.  This only happens
" when typing text, not when typing Vim commands.  This avoids having to switch
" between two keyboard settings.
set keymap=russian-jcukenwin
"Specifies whether :lmap or an Input Method (IM) is to be used in
" Insert mode.  Valid values:
"     0	:lmap is off and IM is off
"     1	:lmap is ON and IM is off
"     2	:lmap is off and IM is ON
set iminsert=0
" Specifies whether :lmap or an Input Method (IM) is to be used when
" entering a search pattern.  Valid values:
"     -1	the value of 'iminsert' is used, makes it look like
"           'iminsert' is also used when typing a search pattern
"     0	:lmap is off and IM is off
"     1	:lmap is ON and IM is off
"     2	:lmap is off and IM is ON
set imsearch=0
" Sets the character encoding used inside Vim.
set encoding=utf-8
" Encoding used for the terminal.
set termencoding=utf-8
" If it contains a command that loads a new buffer, it will be loaded without
" creating a swapfile and the 'swapfile' option will be reset.
" set noswapfile
" When on, splitting a window will put the new window right of the
" current one.
set splitright
" When on, splitting a window will put the new window below the current one.
set splitbelow
" Ignore case in search patterns.  Also used when searching in the tags file.
set ignorecase
" When off a buffer is unloaded when it is abandoned.  When on a
" buffer becomes hidden when it is abandoned.
set hidden
" Highlight at 80 char by default.
set colorcolumn=80
" When there is a previous search pattern, highlight all its matches.
set hlsearch
" While typing a search command, show where the pattern, as it was typed
" so far, matches.  The matched string is highlighted.
set incsearch
" Highlight the screen line of the cursor with CursorLine
" hl-CursorLine.  Useful to easily spot the cursor.  Will make screen
" redrawing slower.
set cursorline
" Determines the maximum number of items to show in the popup menu for
" Insert mode completion.  When zero as much space as available is used.
set pumheight=10
" Characters to fill the statuslines and vertical separators.
set fillchars+=vert:\ 
" Strings to use in 'list' mode and for the |:list| command.  It is a
" comma separated list of string settings.
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
set wildmenu
" When this option is set, the screen will not be redrawn while
" executing macros, registers and other commands that have not been
" typed.  Also, updating the window title is postponed.
set lazyredraw
" When off, all folds are open.  This option can be used to quickly
" switch between showing all text unfolded and viewing the text with
" folds (including manually opened or closed folds).  It can be toggled
" with the |zi| command.  The 'foldcolumn' will remain blank when
" 'foldenable' is off.
set foldenable
" The kind of folding used for the current window.  Possible values:
" |fold-manual|	manual	    Folds are created manually.
" |fold-indent|	indent	    Lines with equal indent form a fold.
" |fold-expr|	expr	    'foldexpr' gives the fold level of a line.
" |fold-marker|	marker	    Markers are used to specify folds.
" |fold-syntax|	syntax	    Syntax highlighting items specify folds.
" |fold-diff|	diff	    Fold text that is not changed.
set foldmethod=indent
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" This option changes how text is displayed.  It doesn't change the text
" in the buffer, see 'textwidth' for that.
set nowrap
" Sets 'foldlevel' when starting to edit another buffer in a window.
" Useful to always start editing with all folds closed (value zero),
" some folds closed (one) or no folds closed (99).
set foldlevelstart=99
" Access your system clipboard
set clipboard=unnamed
" "вечная" отмена изменений
" http://funix.ru/programs_utilities/ispolzovanie-vim-v-povsednevnoj-rabote.html
set undodir=~/.vim/undo/
set undofile
" <leader>
let mapleader=","
let maplocalleader = "\\"

" colors
syntax on
set background=dark
if has('gui_running')
    set t_md=
    colorscheme zenburn
    " colorscheme base16-default-dark

    if has("unix")
        set guifont=DejaVu\ Sans\ Mono\ Book\ 11
        " set guifont=Monospace\ Regular\ 12
        " set guifont=Ubuntu\ Mono\ Regular\ 13
        set lines=60 columns=212 linespace=0
    elseif has ("win32")
        set guifont=Consolas:h11
    endif
else
    set t_Co=256
    colorscheme zenburn

    " let base16colorspace=256
    " colorscheme base16-default-dark
endif

" Режим "вклейки"
" http://funix.ru/programs_utilities/ispolzovanie-vim-v-povsednevnoj-rabote.html
set pastetoggle=<F7>

map <leader>w :wa<CR>
inoremap <leader>r <c-^>

" Auto pair brackets and stuff
iabbr <silent> `` ````<Left><Left><C-R>=Eatchar('\s')<CR>
iabbr <silent> ёё ````<Left><Left><C-R>=Eatchar('\s')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable increment/decrement of numbers, which I've basically always done on
" accident instead of on purpose.
" https://github.com/achalddave/dotfiles/blob/master/vim/vimrc
nnoremap <silent> <C-a> <Nop>
vnoremap <silent> <C-a> <Nop>
nnoremap <silent> <C-x> <Nop>
vnoremap <silent> <C-x> <Nop>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" To make navigating the file easier. This makes k and j move up and down by
" displayed lines not file lines.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Backup
" https://github.com/achalddave/dotfiles/blob/master/vim/vimrc
set backup
" Force backups to be copied, rather than renaming the active file to the
" backup file. If backupcopy is no or auto, it seems to cause some issues with
" NFS, where another terminal on a different machine may hold the handle to
" the backup file instead of the updated file.
set backupcopy=yes
" Adding "//" at the end asks Vim to use the absolute path of the file to avoid
" filename collisions.
if has("win32")
    let mybackupdir = $TEMP . "/vim-backup//"
    let myswpdir = $TEMP . "/vim-swp//"
elseif has("unix")
    let mybackupdir = $HOME . "/.vim/backup//"
    let myswpdir = $HOME . "/.vim/swp//"
endif

if !isdirectory(mybackupdir)
    call mkdir(mybackupdir)
endif
if !isdirectory(myswpdir)
    call mkdir(myswpdir)
endif
execute "set backupdir=".mybackupdir
execute "set directory=".myswpdir

" nerdtree
let NERDTreeAutoDeleteBuffer = 1
" If set to 1, the NERD tree window will close after opening a file
let NERDTreeQuitOnOpen = 0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <leader>nt :NERDTreeToggle<CR>

" undotree
map <leader>ut :UndotreeToggle<CR>:UndotreeFocus<CR>

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
map <C-_> <plug>NERDCommenterToggle
imap <C-_> <esc><plug>NERDCommenterToggle<space>a

" tagbar
let g:tagbar_sort = 0
let g:tagbar_width = 40
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_iconchars = ['+', '-']
map <leader>tb :TagbarToggle<CR>

" vim-easytags
set tags=tags;$HOME/.vim/tags/
let g:easytags_events = ['BufWritePost']
let g:easytags_async = 1

" youcompleteme
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_filetype_blacklist = { 'python' : 1 }

" jedi-vim
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 1

" ultisnips
let g:UltiSnipsExpandTrigger       = "<C-j>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsListSnippets        = "<C-l>" "List possible snippets based on current file
let g:UltiSnipsSnippetDirectories  = ["UltiSnips", "vim-snippets", $HOME.'/.vim-snippets/']

" ack.vim
" ERR: Error in pthread_setaffinity_np(): Invalid argument
" ERR: Performance may be affected. Use --noaffinity to suppress this message.
if executable('ag')
   let g:ackprg = 'ag --noaffinity --vimgrep --smart-case'
endif

" fzf.vim
" https://habrahabr.ru/company/mailru/blog/340740/
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>/ :Lines<CR>
nmap <Leader>? :Rg<CR>
nmap <Leader>gc :Commits<CR>
nmap <leader>s :Snippets<CR>

" edit snippets
nnoremap <leader>se :UltiSnipsEdit<cr>

" fugitive.vim
nmap <Leader>gs :Gstatus<CR>

" vim-easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_shade = 0
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" ALE
" let g:ale_python_pylint_executable = 'pylint3'
" let g:ale_open_list = 1

" syntastic
" :SyntasticInfo python
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1 " syntastic runs all checkers that apply
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_python_checkers = ['python', 'mypy', 'flake8', 'pylint' ]
let g:syntastic_javascript_checkers = ['flow']
" [ruby - How do I fix this annoying syntastic rails error - Stack Overflow](https://stackoverflow.com/questions/29635150/how-do-i-fix-this-annoying-syntastic-rails-error)
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}
let g:syntastic_pylama_args="--max-line-length=120"
" https://stackoverflow.com/questions/20030603/vim-syntastic-how-to-disable-the-checker/21434697#21434697
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': []
\ }
map <leader>sc :write<CR> :SyntasticCheck<CR>
" Debug Syntastic
" :let g:syntastic_debug=3

" airline
" [ryanoasis/nerd-fonts: Iconic font aggregator](https://github.com/ryanoasis/nerd-fonts)
" let g:airline_solarized_bg='dark'
" let g:airline_theme='solarized'
" let g:airline_theme='zenburn'
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" autopep8
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=120

" autoformat
" To disable the fallback to vim's indent file, retabbing and removing
" trailing whitespace, set the following variables to 0.
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" To print the currently selected formatter use :CurrentFormatter
" Debug Autoformat
" let g:autoformat_verbosemode=1

" Usefull Tabular regex for formatting YAML files
" Tab /[0-9a-z_\-]\+:/l1

" LaTeX filetipe by default
let g:tex_flavor='latex'

" textwidth 80 chars for Markdown files
" usefull for auto text formatting with gq shortcut
au BufRead,BufNewFile *.md setlocal textwidth=80
" define :TexTidy command to run latexindent on visual selection || entire buffer"
command -range=% -nargs=* TexTidy <line1>,<line2>!latexindent
" define :PerlTidy command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* PerlTidy <line1>,<line2>!perltidy
" run :PerlTidy on entire buffer and return cursor to (approximate) original position
fun DoTexTidy()
    let l = line(".")
    let c = col(".")
    :TexTidy
    call cursor(l, c)
endfun
" run :PerlTidy on entire buffer and return cursor to (approximate) original position
fun DoPerlTidy()
    let l = line(".")
    let c = col(".")
    :PerlTidy
    call cursor(l, c)
endfun
" Tidy python files
fun DoPyTidy()
    let l = line(".")
    let c = col(".")
    :Isort
    :YAPF
    :write
    :SyntasticCheck
    call cursor(l, c)
endfun
" shortcut for normal mode to run on entire buffer then return to current line
au Filetype perl nmap <leader>pt :call DoPerlTidy()<CR>
au Filetype tex nmap <leader>pt :call DoTexTidy()<CR>
" shortcut for visual mode to run on the the current visual selection
au Filetype perl vmap <leader>pt :PerlTidy<CR>
au Filetype tex vmap <leader>tt :TexTidy<CR>
" autopep8
au FileType python noremap <buffer> <leader>pt :call DoPyTidy()<CR>
" https://github.com/stephpy/vim-yaml/blob/master/after/syntax/yaml.vim
" au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/syntax/yaml.vim
" [VIM and Python – A Match Made in Heaven – RealPython](https://realpython.com/vim-and-python-a-match-made-in-heaven/#python-indentation)
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

au BufNewFile,BufRead *.tex
    \ set wrap
    \ formatoptions+=t
    \ textwidth=79

au FileType perl,python nmap <leader>mt :make test<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Using_command-line_history
" q:     Show command history
" q/     Show search history
