"
" File: .vimrc
" Author: Colps
" Github: https://github.com/colpshift
" Description: vim configuration file 
" Last Modified: 27/12/2018 19:50

"------------------------------------------------------------------------------
" vim settings
"------------------------------------------------------------------------------
set nocompatible        " Use Vim settings then Vi settings.
syntax on				" Enable syntax highlight
filetype on				" Vim will try to recognize the file type
filetype plugin on			
filetype indent on
filetype detect
set encoding=utf-8
set fileformat=unix

"------------------------------------------------------------------------------
" plugins package manager - vim-plug
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-distinguished'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/AutoClose'
Plug 'vim-scripts/indentpython.vim'
Plug 'google/yapf'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'francoiscabrol/ranger.vim'
call plug#end()

"------------------------------------------------------------------------------
" plugins configuration
"------------------------------------------------------------------------------
" gruvbox
	set background=dark
	colorscheme gruvbox
" airline
	let g:airline_theme='gruvbox'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1
" spell
	set spell
	set spelllang=en-US
	set spellsuggest=best,5
	let s:c=",underline"
	let spell_auto_type="text,doc,mail,sh,py"
" YCM
	" make YCM compatible with UltiSnips (using supertab)
	let g:ycm_autoclose_preview_window_after_completion=1
	let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
	let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
	let g:SuperTabDefaultCompletionType = '<C-n>'
"fix_aic94-wd719x UltiSnips
	" better key bindings for UltiSnipsExpandTrigger
	let g:UltiSnipsExpandTrigger = "<tab>"
	let g:UltiSnipsJumpForwardTrigger = "<tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" ALE
	let g:ale_completion_enabled = 0                       
	let g:ale_sign_column_always = 1                      
	let g:ale_set_quickfix = 0
	let g:ale_set_loclist = 0
	let g:airline#extensions#ale#enabled = 1                
	let g:ale_open_list = 1                                
	let g:ale_keep_list_window_open = 0                   
	let g:ale_set_balloons = 1
	" fixers
	let g:ale_fixers = {
	\   'bash': ['shellchek'],
	\   'Bourne Shell': ['shellcheck'],
	\}

"------------------------------------------------------------------------------
" Scripts
"------------------------------------------------------------------------------
" Restore Folds 
function RestoreFolds()
    if @% == ""
        " No filename for current buffer
        startinsert
    elseif filereadable(@%) == 0
        " File doesn't exist yet
        startinsert
    elseif line('$') == 1 && col('$') == 1
        " File is empty
        startinsert
	else
		" restore folds
		au BufWinEnter * silent loadview
	endif
endfunction

"------------------------------------------------------------------------------
" mapping and abbreviations
"----------------------------------------------'--------------------------------
ab ~/ $HOME
" auto indent the whole file and keep your cursor in the last position
nmap <leader>ia mzgg=G`z
" undo hlsearch
nnoremap <space> :nohlsearch<CR>
" insert timestamp
inoremap <F10> <C-R>=strftime("%d/%m/%Y %H:%M")<CR>
" complete parameters
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
	
"------------------------------------------------------------------------------
" python - programming
"------------------------------------------------------------------------------
" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" enable all python highlight
let python_highlight_all=1
	
"------------------------------------------------------------------------------
" interface
"------------------------------------------------------------------------------
set shortmess=atIc		" Don’t show the intro message when starting Vim
set number
set relativenumber             
set cursorline         
set nostartofline		" Don’t reset cursor start of line when moving around.
set clipboard=unnamed   " to use clipboard
set ruler               " right side of the status line at the bottom
set showmode            " change the color in according of mode
set mouse=a             " allow mouse clicks to change cursor position
set showmatch           " highlight matching [{()}]
set wildmenu            " expand the menu
set showcmd             " show command in bottom bar
set colorcolumn=+1      " color de last column to wrap.
set textwidth=79        " set width for text
set winwidth=100        " set the minimal width of the current window.

"------------------------------------------------------------------------------
" searching
"------------------------------------------------------------------------------
set ignorecase " case insensitive
set smartcase  " use case if any caps used 
set incsearch  " show match as search proceeds
set hlsearch   " highlight matches

"------------------------------------------------------------------------------
" indenting
"------------------------------------------------------------------------------
set autoindent          " indent match with the previous line
set smartindent         " indent after colon for if or for statements
set tabstop=4           " Python default           
set shiftwidth=4        " The amount to block indent when using 
set softtabstop=4       " Causes backspace to delete 4 spaces converted TAB
set smarttab            " Uses shiftwidth instead of tabstop at start of lines
set noexpandtab         " Replaces a TAB with spaces--more portable
set backspace=eol,start,indent	" Make sure backspace works in insert mode

"------------------------------------------------------------------------------
" folding
"------------------------------------------------------------------------------
set foldenable							" enable fold
set foldmethod=indent					" fold based on indent level
set foldcolumn=4						" show column indent
au BufWinLeave * mkview					" save folds
au VimEnter * call RestoreFolds()		

"------------------------------------------------------------------------------
" swap, undo and backup
"------------------------------------------------------------------------------
set swapfile
set directory=$HOME/.vim/swaps/  
set undofile
set undodir=$HOME/.vim/undo/
set backup
set backupdir=$HOME/.vim/backups/
