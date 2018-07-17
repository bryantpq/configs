" Auto install vim plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'         " file directory
" Plug 'scrooloose/syntastic'        " linter
Plug 'w0rp/ale'                    " linter
Plug 'ervandew/supertab'           " tab completion
Plug 'yggdroot/indentline'         " shows indentation for lines
Plug 'bling/vim-bufferline'        " shows open buffers
call plug#end()

" =========== NERDTree =============
map <C-n> :NERDTreeToggle<CR>

" =========== Syntastic ============
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" =========== Indent line ==========
" only works with indentation with spaces
nnoremap <leader>il :IndentLinesToggle<cr>
let g:indentLine_enabled = 1
let g:indentLine_color_term = 8
let g:indentLine_char = '¦' " use any ASCII character

" TODO
" Find and replace strings

" My statusbar
set statusline=\ %F\ \%m
set statusline+=%=\[\%c\,\%l\/\%L\]\  

set updatetime=250

let mapleader = "\\"
set nohlsearch " turn off highlighted search until needed
highlight LineNr ctermfg=yellow
syntax enable
" set autowriteall " save any changes before hiding a buffer
set autoindent
set background=light
set backspace=indent,eol,start " backspace deletes previous character
set encoding=utf-8
set expandtab " tabs to spaces
set incsearch
set laststatus=2 " enable statusbar
set number
set shiftwidth=4 " affects >> in normal mode
set tabstop=4 " size of tab
set t_Co=256
set title
set ttyfast
set cursorline

hi Search guibg=LightBlue

inoremap <leader>s <c-o>:w<cr>A
" inoremap { {<CR>}<Esc>k$a

" Make Enter/Backspace go forward/backward one paragraph
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

" Keeps text highlighted when fixing indentation
vnoremap < <gv
vnoremap > >gv

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

nnoremap U <C-R>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>h :set hlsearch!<cr>
nnoremap <leader>w <C-W>k
nnoremap <leader>s <C-W>j
nnoremap <leader>a <C-W>h
nnoremap <leader>d <C-W>l
nnoremap <leader>W <C-W>K
nnoremap <leader>S <C-W>J
nnoremap <leader>A <C-W>H
nnoremap <leader>D <C-W>L

autocmd BufWinLeave *.* mkview          " save the current view when exiting
autocmd BufWinEnter *.* silent loadview 

" Print a useful title for xterm on exit
" let &titleold=getcwd()

" BASIC KEYS IN NORMAL MODE
" H go to top of screen
" L go to bottom of screen
" w go to start of next word
" | go to beginning of line
" $ go to end of line
" ma set mark named a
" `a go to mark named a


" BASIC COMMANDS NORMAL MODE
" :ls
"   list and enumerate opened buffers
" :b2
"   open buffer for file number 2 (as indexed by :ls)
" :bd
"   close current buffer, fails if unsaved
" :buffers
"   lists buffers and waits for a number to open that buffer
" <c-6>
"   swaps between current and previous buffer
" :vsplit file or :split file
"   opens specified file in a new window
"   CTRL + w + [hjkl] navigates to a split buffer
"   CTRL + w + [HJKL] moves the current buffer to a new position


" VIMRC COMMANDS
" noremap, nnoremap, vnoremap and inoremap
"   to map keys in respective modes (All, Normal, Visual, Insert)
" iabbrev str1 str2
"   changes str1 to str 2 in insert mode when any non-keyword character is entered after str1
" set iskeyword?
"   displays keyword chars, by default alphanumeric and underscore are keyword chars
" autocmd event filter cmd
"   when event happens, run cmd after filtering for filter
"   :help autocmd-events to see list of events


" NOTABLE KEYS
" <leader> refers to pressing whatever the leader key is binded to, does not need to be held down to be used like CTRL key
" <bs> backspace
" <space> SPACEBAR " <c-d> CTRL + d
" <cr> carriage return i.e. ENTER


" RANDOM (MIGHT BE USEFUL LATER ON) STUFF
" in visual mode, iw selects the entire word under cursor
" in visual mode, u converts the selection to uppercase
" $myvimrc refers to the path of the .vimrc file, useful to quickly edit it, needs to be sourced after to take effect immediately
" binding a key to <nop> makes it do nothing
