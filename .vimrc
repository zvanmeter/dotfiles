"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = " "

" Better copy & paste
" Sep 2017: A lot seems unneeded in macos brew vim... revisit in linuxland later

" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
" set pastetoggle=<F2>
" set clipboard=unnamed
" clipcopy is OhMyZSH installed
" autocmd VimLeave * call system("clipcopy", getreg('+'))

" Copy visual selection to system clipboard
map <leader>c "+y

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Hard Mode: Disable Arrow Keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Bind nohl - Removes highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Insert Line from normal mode
nnoremap <C-o> I<CR><Esc>k0D

" Quicksave command/
" Note - Add "stty -ixon" to .zshrc file
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim https://vim.sourceforge.io/scripts/download_script.php\?src_id\=13400
" curl -o wombat256mod.vim https://vim.sourceforge.io/scripts/download_script.php\?src_id\=13400
 set t_Co=256
 color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number  " show line numbers
set relativenumber " show relative line numbers
set tw=96   " width of document (used by gd)
"set nowrap  " don't automatically wrap on load
"set fo-=t   " don't automatically wrap text when typing
nnoremap <C-l> :set relativenumber!<cr>
set ruler

" Disable relative numbers on lost focus
:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber

"Disable relative numbers in insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

if exists("&colorcolumn")
    set colorcolumn=96
    highlight ColorColumn ctermbg=233
    autocmd FileType gitcommit set colorcolumn=50,72
    autocmd FileType gitcommit highlight ColorColumn ctermbg=022
endif

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" git commit
autocmd FileType gitcommit set spell spelllang=en_us

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events for file system watchers
set nobackup
set nowritebackup
set noswapfile
