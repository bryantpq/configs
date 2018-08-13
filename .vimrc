if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'         " file directory
" Plug 'scrooloose/syntastic'        " linter
Plug 'ervandew/supertab'           " tab completion
Plug 'yggdroot/indentline'         " shows indentation for lines
Plug 'bling/vim-bufferline'        " shows open buffers
" Plug 'tpope/vim-surround'          " handle surrounding braces and stuff
" Plug 'airblade/vim-gitgutter'      " shows git diff details
" Plug 'majutsushi/tagbar'           " shows summary of file struct
" Plug 'valloric/youcomplete'        " tab completion
" Plug 'xuyuanp/nerdtree-git-plugin' " NERDTree git status
" Plug 'w0rp/ale'                    " linter
call plug#end()

" 
" ********************* PlugIn Settings ***********************
"
" NERDTree
nnoremap <C-o> :NERDTreeToggle<CR>

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Indent line
" only works with indentation with spaces
nnoremap <leader>il :IndentLinesToggle<cr>
let g:indentLine_enabled = 1
let g:indentLine_color_term = 8
let g:indentLine_char = '¦' " use any ASCII character

"
" ********************* End PlugIn Settings ********************
"

" General
syntax enable
set autoindent
set hidden " keeps buffer hidden rather than abandoned when switching buffers, keeps undo history
set background=light " tell vim what the background color looks like
set t_Co=256 " enable 256 colors in vim
set backspace=indent,eol,start " backspace deletes previous character
set encoding=utf-8
set expandtab " tabs to spaces
set shiftwidth=4 " affects >> in normal mode
set tabstop=4 " size of tab
set number
set title
set ttyfast
set cursorline
set wildmenu " visual autocomplete for command menu
set updatetime=250
" set autowriteall " save any changes before hiding a buffer
autocmd BufWinEnter *.* silent loadview 
autocmd BufWinLeave *.* mkview
highlight LineNr ctermfg=yellow
" set color of current line number
hi CursorLineNR ctermfg=gray


" Statusbar
set laststatus=2 " enable statusbar
set statusline=\ %F\ \%m
set statusline+=%=\[\%c\,\%l\/\%L\]\  


" Search highlighting
hi Search ctermbg=yellow
hi Search ctermfg=black
set nohlsearch " turn off highlighted search until needed
set incsearch " async search


" ***************** KeyBindings *******************
let mapleader = "\\"

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

" # A way to delete 'mkview', just type :delview
function! MyDeleteView()
	let path = fnamemodify(bufname('%'),':p')
	" vim's odd =~ escaping for /
	let path = substitute(path, '=', '==', 'g')
	if empty($HOME)
	else
		let path = substitute(path, '^'.$HOME, '\~', '')
	endif
	let path = substitute(path, '/', '=+', 'g') . '='
	" view directory
	let path = &viewdir.'/'.path
	call delete(path)
	echo "Deleted: ".path
    autocmd! BufWinLeave *.*
endfunction
command! Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>


" :%s/foo/bar/g     find all occurrences of foo in all lines and replace
" :s/foo/bar/gi     find all occurences (case-insensitive) of foo in current line and replace
" :%s/foo/bar/gc    same as fist but confirm before replace

" BASIC KEYS IN NORMAL MODE
" H go to top of screen
" L go to bottom of screen
" w go to start of next word
" | go to beginning of line
" $ go to end of line
" ma set mark named a
" `a go to mark named a

" BASIC COMMANDS NORMAL MODE
" :bd
"   close current buffer, fails if unsaved
" :buffers
"   lists buffers and waits for a number to open that buffer
" <c-6>
"   swaps between current and previous buffer

" VIMRC COMMANDS
" noremap, nnoremap, vnoremap and inoremap
"   to map keys in respective modes (All, Normal, Visual, Insert)
" iabbrev str1 str2
"   changes str1 to str 2 in insert mode when any non-keyword character is entered after str1
" set iskeyword?
"   displays keyword chars, by default alphanumeric and underscore are keyword chars

" RANDOM (MIGHT BE USEFUL LATER ON) STUFF
" in visual mode, iw selects the entire word under cursor
" in visual mode, u converts the selection to uppercase
" $myvimrc refers to the path of the .vimrc file, useful to quickly edit it, needs to be sourced after to take effect immediately
" binding a key to <nop> makes it do nothing
