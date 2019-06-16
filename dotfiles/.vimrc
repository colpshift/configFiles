"
" File: .vimrc
" Author: Colps
" Github: https://github.com/colpshift
" Description: vim configuration file
" Last Modified: June 14, 2019
"

"------------------------------------------------------------------------------
" start settings
"------------------------------------------------------------------------------
set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on
filetype detect
set fileformat=unix
set autoread			" Automatically re-read files if unmodified inside Vim.
set confirm             " Display confirmation dialog when closing unsaved file.
set nomodeline          " Ignore file’s mode lines.

"------------------------------------------------------------------------------
" Performance
"------------------------------------------------------------------------------
set complete-=i		" Limit the files searched for auto-completes.
set lazyredraw		" Don’t update screen during macro and script execution.

"------------------------------------------------------------------------------
" Text Rendering
"------------------------------------------------------------------------------
set display+=lastline	" Always try to show a paragraph’s last line.
set encoding=utf-8		" Use an encoding that supports unicode.
set linebreak			" Avoid wrapping a line in the middle of a word.
set scrolloff=1			" Number screen lines keep above and below cursor.
set sidescrolloff=5		" Number screen columns keep  left and right cursor.
set wrap				" Enable line wrapping.

"------------------------------------------------------------------------------
" Auto commands
"------------------------------------------------------------------------------
"au BufWinLeave * mkview				" save folds
"au VimEnter * call RestoreFolds()		" restore folds

"------------------------------------------------------------------------------
" Scripts
"------------------------------------------------------------------------------
" Restore Folds
function RestoreFolds()
    if @% == ""
		set encoding=utf-8
    elseif filereadable(@%) == 0
		set encoding=utf-8
    elseif line('$') == 1 && col('$') == 1
		set encoding=utf-8
	else
		au BufWinEnter * silent loadview
	endif
endfunction

"------------------------------------------------------------------------------
" plugins package manager - vim-plug
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
	Plug 'junegunn/vim-plug'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'morhetz/gruvbox'
	Plug 'TaDaa/vimade'
	Plug 'luochen1990/rainbow'
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
" rainbow
let g:rainbow_active = 1
" gruvbox
    let g:gruvbox_contrast_dark = 'medium'
    let g:gruvbox_invert_tabline = '1'
    let g:gruvbox_invert_indent_guides = '1'
    let g:gruvbox_improved_strings = '0'
    let g:gruvbox_improved_warnings ='1'
" vimade
    let g:vimade = {}
    let g:vimade.fadelevel = 0.3
" airline
    let g:airline_theme='gruvbox'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
" spell
    "set spell
    "set spelllang=en-US
    "set spellsuggest=best,5
    "let s:c=",underline"
    "let spell_auto_type="text,doc,mail,"
" YCM
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'
" UltiSnips
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" ALE
    let g:ale_enabled = 0
    let g:ale_completion_enabled = 1
    let g:ale_sign_column_always = 1
    let g:ale_set_highlights = 1
    let g:ale_echo_cursor = 1
    let g:ale_cursor_detail = 1
    let g:ale_set_quickfix = 1
    let g:ale_set_loclist = 0
    let g:airline#extensions#ale#enabled = 1
    let g:ale_list_window_size = 5
    let g:ale_lint_on_text_changed = 1
    let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}
    let g:ale_enabled = 1

"------------------------------------------------------------------------------
" mapping and abbreviations
"----------------------------------------------'--------------------------------
" abbreviations
ab ~/ $HOME
" run :w!! command (type fast), to save ready only files.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
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
set clipboard+=unnamed  " to use clipboard
set ruler               " right side of the status line at the bottom
set showmode            " change the color in according of mode
set mouse=a             " allow mouse clicks to change cursor position
set showmatch           " highlight matching [{()}]
set wildmenu            " expand the menu
set showcmd             " show command in bottom bar
set colorcolumn=+1      " color de last column to wrap.
set textwidth=79        " set width for text
set winwidth=100        " set the minimal width of the current window.
set noerrorbells		" Disable beep on errors.
set visualbell			" Flash the screen instead of beeping on errors.
set background=dark
colorscheme gruvbox

"------------------------------------------------------------------------------
" searching
"------------------------------------------------------------------------------
set ignorecase " case insensitive
set smartcase  " use case if any caps used
set incsearch  " show match as search proceeds
set hlsearch   " highlight matches

"------------------------------------------------------------------------------
" indention
"------------------------------------------------------------------------------
set autoindent          " indent match with the previous line
set smartindent         " indent after colon for if or for statements
set tabstop=4           " Python default
set shiftwidth=4        " The amount to block indent when using
set shiftround			" Round the indentation to earest multiple shiftwidth.
set softtabstop=4       " Causes backspace to delete 4 spaces converted TAB
set smarttab            " Uses shiftwidth instead of tabstop at start of lines
set expandtab			" Replaces a TAB with spaces--more portable
set backspace=eol,start,indent	" Make sure backspace works in insert mode

"------------------------------------------------------------------------------
" folding
"------------------------------------------------------------------------------
set foldenable			" enable fold
set foldmethod=indent	" fold based on indent level
set foldcolumn=3		" show column indent

"------------------------------------------------------------------------------
" swap, undo and backup
"------------------------------------------------------------------------------
set swapfile
set directory=$HOME/.vim/swaps/
set undofile
set undodir=$HOME/.vim/undo/
set backup
set backupdir=$HOME/.vim/backups/