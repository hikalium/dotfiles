syntax on

call plug#begin()
	Plug 'leafgarland/typescript-vim'
	Plug 'jason0x43/vim-js-indent'
	Plug '2072/PHP-Indenting-for-VIm'
	Plug 'groenewege/vim-less'
	Plug 'Shougo/vinarise'
	Plug 'fatih/vim-go'
	Plug 'vim-syntastic/syntastic'
	Plug 'Lokaltog/powerline'
	Plug 'rhysd/vim-clang-format'
	Plug 'guns/xterm-color-table.vim'
	Plug 'rust-lang/rust.vim'
	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'luochen1990/rainbow'
	Plug 'guns/xterm-color-table.vim'
	" :XtermColorTable to show color tables
call plug#end()

set nocompatible
set backspace=indent,eol,start
set wildignore+=*.pdf,*.o,*.obj,*.jpg,*.png

set splitbelow
set splitright

set tabstop=4
set shiftwidth=4

set autoread
if has("autocmd")
  augroup vimrc-checktime
    autocmd!
    autocmd InsertEnter,WinEnter * checktime
  augroup END
endif

" Status Line Settings
set statusline=%F " Show file name
set statusline+=%m " Show modification
set statusline+=%r " Show if readonly
set statusline+=%h " Show if help
set statusline+=%w " Show if preview
set statusline+=:%l " Show line number
set statusline+=%= " align right after this
set statusline+=\ %Y[%{&fileencoding}] " file encoding
set laststatus=2 " Show status line (0:never, 1:two or more windows, 2:always)

" Colors
hi Search cterm=NONE ctermfg=black ctermbg=191
hi Visual cterm=NONE ctermfg=black ctermbg=191
hi StatusLine term=NONE cterm=NONE ctermfg=230 ctermbg=22
hi VertSplit term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
hi NonText term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
hi SpecialKey term=NONE cterm=NONE ctermfg=23 ctermbg=NONE
hi MatchParen ctermbg=4

hi Pmenu ctermbg=131
hi PmenuSel ctermbg=124

hi TabLineFill ctermfg=22 ctermbg=22
hi clear TabLine
hi TabLine ctermfg=230 ctermbg=22
hi TabLineSel ctermfg=230 ctermbg=166

" luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" Show current buffer name on tab
function! s:tabpage_label(n)
	" use t:title if exists
	let title = gettabvar(a:n, 'title')
	if title !=# ''
		return title
	endif
	" Get list of buffers inside a current tab
	let bufnrs = tabpagebuflist(a:n)
	" Highlight a current tab
	let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

	" show '+' if there are modified buffers
	let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
	" Get current buffer
	let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() is 1-indexed
	let fname = pathshorten(bufname(curbufnr))

	let label = fname . mod

	return '%' . a:n . 'T' . hi . ' [' . label . '] ' . '%T%#TabLineFill#'
endfunction

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

function! MakeTabLine()
	let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
	let sep = ' '  " delimiter
	let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
	let hostname = ChompedSystem('hostname')
	let info = 'vim@' . hostname  " show whatever you want
	return tabpages . '%=%#TabLine#' . info  " show tab lists on leftside, informations on rightside
endfunction

set showtabline=2
set guioptions-=e
set tabline=%!MakeTabLine()

set number
set hlsearch
set printoptions=number:y,left:10mm
set background=light
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error
set printfont=Source_Code_Pro:h10
let g:localvimrc_persistent=2 " save whether trusted or not

"let g:neocomplete#enable_at_startup = 1
let g:js_indent_typescript = 0
set noautoindent
set nosmartindent
setlocal indentexpr=
setlocal formatoptions-=r
setlocal formatoptions-=o
set formatoptions-=ro
au FileType * setlocal formatoptions-=ro

" golang
" http://pandazx.hatenablog.com/entry/2014/05/30/232911
" use goimports instead of gofmt on :Fmt
let g:gofmt_command = 'goimports'

" Enable plugin and gocode
set rtp^=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
syntax on
au FileType go compiler go
filetype plugin on
let g:go_fmt_command = "goimports"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustup run nightly rustfmt'

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "passive_filetypes": ["html"] }
let g:syntastic_cpp_compiler_options=" -std=c++1z"

if has('win32')
	let s:ostype = "Win"
elseif has('mac')
	let s:ostype = "Mac"
else
	let s:ostype = "Linux"
endif

let g:clang_format#code_style = 'Google'
let g:clang_format#detect_style_file = 1

if $TMUX != ""
	augroup titlesettings
		autocmd!
		autocmd BufEnter * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
		autocmd VimLeave * call system("tmux rename-window bash")
		autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
	augroup END
endif

set wildmode=list:longest

nnoremap <Return><Return> <c-w><c-w>

" Disable Ex mode
map Q <Nop>

" Use Tab key to move between tabs
" http://blog.remora.cx/2012/09/use-tabpage.html
nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
	execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

cnoreabbrev tn tabnew
cnoreabbrev vs vsplit


au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile,BufRead *.cc set filetype=cpp
au BufNewFile,BufRead *.h set filetype=cpp
au BufNewFile,BufRead *.ejs set filetype=html

au FileType cpp set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set expandtab

au FileType c set tabstop=2
au FileType c set shiftwidth=2
au FileType c set expandtab

au FileType markdown set tabstop=2
au FileType markdown set shiftwidth=2
au FileType markdown set expandtab

au FileType html set tabstop=2
au FileType html set shiftwidth=2
au FileType html set expandtab
au FileType html set noautoindent
au FileType html set nocindent
au FileType html set nosmartindent

au FileType fortran set noexpandtab

