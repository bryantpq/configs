if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'         " file directory
Plug 'yggdroot/indentline'         " shows indentation for lines
Plug 'tpope/vim-surround'          " handle surrounding braces and stuff
Plug 'w0rp/ale'                    " linter
Plug 'ervandew/supertab'           " tab completion
Plug 'ctrlpvim/ctrlp.vim'          " buffers and files
call plug#end()

" ********************* PlugIn Settings ***********************

" Ale, :ALEInfo
" Only run linter when buffer is entered or saved
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_echo_cursor = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
let g:ale_python_flake8_options='--ignore=E501,E261,E221,E201,E202,W391,F841,E265,E266'
let g:ale_echo_msg_format = '[%linter%%-code%] %severity%: %s'
hi ALEWarning ctermfg=Black ctermbg=Yellow
hi ALEError ctermfg=White ctermbg=Red
hi ALEInfo ctermfg=White ctermbg=DarkBlue
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" turn off linter
nnoremap <leader>at :ALEToggle<CR> 

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    if l:counts.total == 0
        hi LinterStat ctermfg=black ctermbg=green cterm=none
        return ' ( OK ) '
    else
        hi LinterStat ctermfg=black ctermbg=magenta cterm=none
        return ' (W:'.all_non_errors.' E:'.all_errors.') '
    endif
endfunction

" CtrlP
" <F5> purge the cache, get new files, remove deleted files, apply ignore options.
" <c-f> and <c-b> to cycle between modes.
" <c-d> to switch to filename only search instead of full path.
"" <c-j>, <c-k> or the arrow keys to navigate the result list.
" <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" <c-n>, <c-p> to select the next/previous string in the prompt's history.
" <c-y> to create a new file and its parent directories.
" <c-z> to mark/unmark multiple files and <c-o> to open them.
let g:ctrlp_map = ',f'
nnoremap <silent> ,b :CtrlPBuffer<CR>


" NERDTree
nnoremap <C-o> :NERDTreeToggle<CR>

" IndentLine
" only works with indentation with spaces
nnoremap <leader>il :IndentLinesToggle<cr>
let g:indentLine_enabled = 1
let g:indentLine_color_term = 8
let g:indentLine_char = '¦' " supports any ASCII character

" ********************* End PlugIn Settings ********************

" General
filetype on
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
set title
set ttyfast
set cursorline
set wildmenu " visual autocomplete for command menu when hitting TAB
set updatetime=250
" set autowriteall " save any changes before hiding a buffer
autocmd BufWinEnter *.* silent loadview 
autocmd BufWinLeave *.* mkview
highlight LineNr ctermfg=yellow
" set color of current line number
hi CursorLineNR ctermfg=gray

" Set number and relativenumber for lines
set number relativenumber
" Disable relativenumber when inserting
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Statusbar
" Make highlight group for status
hi StatusLine ctermfg=15 guifg=#ffffff ctermbg=darkblue guibg=#4e4e4e cterm=none gui=none
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=233 guibg=#3a3a3a cterm=none gui=none
set laststatus=2 " enable statusbar
set statusline=
set statusline+=\ %.50F\%m

set statusline+=%=
set statusline+=\[%c\,\%l\/\%L\]\ 
set statusline+=%#LinterStat#
set statusline+=%{LinterStatus()}


" Search highlighting
hi Search ctermbg=yellow
hi Search ctermfg=black
set nohlsearch " turn off highlighted search until needed
set incsearch " async search as you type


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

nnoremap U <C-R>
inoremap jkj <ESC>
nnoremap - $
vnoremap - $
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
