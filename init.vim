set encoding=utf-8
scriptencoding utf-8
" set term=xterm-256color
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
set title

" setup vim-plug (run :PlugInstall to install plugins)
call plug#begin('~/.vim/plugged')

" enable NERD tree - allows you to explore your filesystem
" and to open files and directories.
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'joshdick/onedark.vim'

Plug 'majutsushi/tagbar'

" Needs vim8 with python3
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vetur'

" Cscope script
Plug 'joe-skb7/cscope-maps'

Plug 'vim-airline/vim-airline'

" Linux Kernel Coding Style
Plug 'vivien/vim-linux-coding-style'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'

" Plug 'zxqfl/tabnine-vim'

Plug 'stanangeloff/php.vim'

Plug 'shawncplus/phpcomplete.vim'

Plug 'othree/html5.vim'

Plug 'jwalton512/vim-blade'

Plug 'noahfrederick/vim-laravel'

Plug 'othree/html5.vim'

Plug 'mattn/emmet-vim'

Plug 'moll/vim-node'

Plug 'ap/vim-css-color'

Plug 'hail2u/vim-css3-syntax'

Plug 'scrooloose/syntastic'

Plug 'tpope/vim-fugitive'

Plug 'alvan/vim-closetag'

Plug 'yggdroot/indentline'

" Plug 'vbe0201/vimdiscord'
" Plug 'vim-scripts/taglist.vim'

" Plug 'sheerun/vim-polyglot'

Plug 'apzelos/blamer.nvim'

" Plug 'ervandew/supertab'

Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-projectionist'        "|
" Plug 'roxma/nvim-completion-manager'  "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'

" Plug 'valloric/youcompleteme'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

Plug 'airblade/vim-gitgutter'

" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'davisdude/vim-love-docs'

Plug 'tbastos/vim-lua'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'nvim-lua/completion-nvim'

Plug 'posva/vim-vue'

Plug 'pangloss/vim-javascript'

Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()

set updatetime=250

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:ycm_autoclose_preview_window_after_insertion = 1 
let g:ycm_filetype_blacklist = {'go': 1}


" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


" Configuration Golang
filetype plugin indent on

set autowrite

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" au filetype go inoremap <buffer> . .<C-x><C-o>
"

let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0

let g:airline_powerline_fonts = 1

" Open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" When open change the focus to the file (and not the NERDTree)
" autocmd! VimEnter * NERDTree | wincmd w
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" MyNext() and MyPrev(): Movement between tabs OR buffers
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" Configure the colorscheme
set background=dark
colorscheme onedark
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

 "let g:onedark_termcolors=16

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
let g:palenight_terminal_italics=1

" Shows the line numbers
" set number relativenumber
" set nu rnu
set nu!

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 2 spaces
set shiftwidth=2     " indent also with 2 spaces
set expandtab        " expand tabs to spaces
" turn syntax highlighting on
set t_Co=256
syntax on
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" Enables the mouse wheel and the use in visual mode
set mouse=a
" Enable clipboard copy paste. If it is not working
" just install gvim (even if you don't use it
" to install de dependencies
set clipboard=unnamedplus

set list
set listchars=tab:>.,trail:~,extends:>,precedes:<

" Fix the ctrl + arrow key problem in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif


" enhanced tab completion on commands
set wildmenu
" set wildmode=longest:list,full

set confirm

let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.blade.php, *.vue'

" Search
set hlsearch     " highlight matches
set incsearch    " incremental searching
set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter

" CTAGS
set tags=tags

" MAPPINGS
map q :quit<CR>
map <C-q> :quit!<CR>
map <C-s> :w<CR>

" Remove all trailing spaces
nnoremap <silent> <F4> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" (F5) Build tags of your own project
nnoremap <F5> <ESC>:!ctags -R --extra=+fq --c-kinds=+px --fields=+iaS .<CR><CR>
         \:!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
         \:!cscope -b -i cscope.files -f cscope.out<CR>
         \:cs reset<CR>

" (F8) Open the Tagbar
nmap <F8> :TagbarToggle<CR>

map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
nnoremap L <ESC>:call MyNext()<CR>
nnoremap H <ESC>:call MyPrev()<CR>

" (CTRL-O) open nerd tree
nnoremap <C-o> <ESC>:NERDTreeToggle<CR>

" Linux Coding Plugin Settings
let g:linuxsty_patterns = [ "/linux/", "/kernel/" ]
nnoremap <silent> <F3> :LinuxCodingStyle<CR>


" nnoremap <Left> <nop>
" nnoremap <Right> <nop>
" nnoremap <Up> <nop>
" nnoremap <Down> <nop>
