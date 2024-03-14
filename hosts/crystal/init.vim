" Neovim config

" Setup Commands:
" (shell)
" ~/dotfiles/scripts/setup_nvim_linux.sh
" source ~/.bashrc
" (nvim)
" :PlugInstall
" :CocInstall coc-rust-analyzer

syntax on

call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'rust-lang/rust.vim'
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

" Coc.nvim
" https://github.com/neoclide/coc.nvim
set cmdheight=2
set updatetime=300

" Status Line Settings
set statusline=%F " Show file name
set statusline+=%m " Show modification
set statusline+=%r " Show if readonly
set statusline+=%h " Show if help
set statusline+=%w " Show if preview
set statusline+=:%l " Show line number
set statusline+=%= " align right after this
set statusline+=\ %Y[%{&fileencoding}] " file encoding
"set statusline+=%{coc#status()}
set laststatus=2 " Show status line (0:never, 1:two or more windows, 2:always)

" Colors
" 22: dark green
" 191: yellow
" StatusLine: bottom line
hi clear TabLine

hi CocErrorSign ctermfg=191 ctermbg=NONE
hi CocInfoSign ctermfg=191 ctermbg=NONE
hi CocWarningSign ctermfg=191 ctermbg=black

hi FgCocErrorFloatBgCocFloating ctermfg=9
hi FgCocHintFloatBgCocFloating ctermfg=4

hi MatchParen ctermbg=4
hi NonText term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
hi Pmenu ctermbg=191
hi PmenuSel ctermbg=124
hi Comment ctermfg=191
hi Search cterm=NONE ctermfg=black ctermbg=191
hi SpecialKey ctermfg=23 ctermbg=NONE
hi StatusLine cterm=NONE gui=NONE ctermfg=white ctermbg=22
hi TabLine ctermfg=230 ctermbg=22
hi TabLineFill ctermfg=22 ctermbg=22
hi TabLineSel ctermfg=230 ctermbg=166
hi VertSplit term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
hi Visual cterm=NONE ctermfg=black ctermbg=191
hi SpecialKey ctermfg=23
hi SignColumn ctermbg=NONE

" Hightlight tab chars
set list
set listchars=tab:>_

augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=red ctermbg=197
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

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
"set printoptions=number:y,left:10mm
set background=light
"set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error
"set printfont=Source_Code_Pro:h10
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
" let g:rustfmt_command = 'rustup run nightly rustfmt'

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

" Move between windows
nnoremap <Return><Return> <c-w><c-w>
" Edit vimr configuration file
nnoremap confe :e $MYVIMRC<CR>
" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>

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

set encoding=utf-8

au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile,BufRead *.cc set filetype=cpp
au BufNewFile,BufRead *.h set filetype=cpp
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.satyh set filetype=satysfi
au BufNewFile,BufRead *.pl set filetype=

autocmd FileType go AutoFormatBuffer gofmt

au FileType asm set tabstop=2
au FileType asm set shiftwidth=2
au FileType asm set expandtab
au FileType asm au BufWritePre <buffer> %s/\s\+$//e

au FileType cpp set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set expandtab

au FileType satysfi set tabstop=2
au FileType satysfi set shiftwidth=2
au FileType satysfi set expandtab

au FileType c set tabstop=2
au FileType c set shiftwidth=2
au FileType c set expandtab

au FileType markdown set tabstop=2
au FileType markdown set shiftwidth=2
au FileType markdown set expandtab

au FileType javascript set tabstop=2
au FileType javascript set shiftwidth=2
au FileType javascript set expandtab
au FileType javascript noremap <buffer> = :ClangFormat<cr>

au FileType typescript set tabstop=2
au FileType typescript set shiftwidth=2
au FileType typescript set expandtab
au FileType typescript noremap <buffer> = :ClangFormat<cr>

au FileType json set tabstop=2
au FileType json set shiftwidth=2
au FileType json set expandtab
au FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
au FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>

au FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
au FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

au FileType html set tabstop=2
au FileType html set shiftwidth=2
au FileType html set expandtab
au FileType html set noautoindent
au FileType html set nocindent
au FileType html set nosmartindent
au FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
au FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>

au FileType fortran set noexpandtab

au FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

let s:ir_signals_path = '/Users/hikalium/repo/remo-ir-signals/'
let s:send_sh_path = s:ir_signals_path . '/send.sh'
let s:on_json_path = s:ir_signals_path . 'on.json'
let s:off_json_path = s:ir_signals_path . 'off.json'
command! TurnOnLight
\ execute ':silent !' . s:send_sh_path . ' ' . s:on_json_path | 
\ execute ':redraw!'
command! TurnOffLight
\ execute ':silent !' . s:send_sh_path . ' ' . s:off_json_path | 
\ execute ':redraw!'

"try
" hit [c in normal mode to jump to next error
"    nmap <silent> [c :call CocAction('diagnosticNext')<cr>
"    nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
"endtry

set guicursor=i:block
set noshowcmd
set langmenu=none
" language en_US

" Hit enter to select suggestion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

set mouse=
