syntax on
set nocompatible
set backspace=indent,eol,start
set laststatus=2
set tabstop=4
set shiftwidth=4
set number
set hlsearch
set printoptions=number:y,left:10mm
set background=light
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error
set printfont=Source_Code_Pro:h10
let g:localvimrc_persistent=2 " 一度聞いたファイルを記録しておき、次回からは自動で読み込む
hi Pmenu ctermbg=131
hi PmenuSel ctermbg=124

call plug#begin()
	Plug 'leafgarland/typescript-vim'
	Plug 'jason0x43/vim-js-indent'
	Plug '2072/PHP-Indenting-for-VIm'
	Plug 'groenewege/vim-less'
	Plug 'Shougo/vinarise'
	Plug 'fatih/vim-go'
	"Plug 'justmao945/vim-clang'
	"Plug 'Shougo/neocomplete.vim'
call plug#end()

"let g:neocomplete#enable_at_startup = 1
let g:js_indent_typescript = 0
au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile,BufRead *.h set filetype=c
set noautoindent
set nosmartindent
setlocal indentexpr=
setlocal formatoptions-=r
setlocal formatoptions-=o
set formatoptions-=ro
au FileType * setlocal formatoptions-=ro

" golang
" http://pandazx.hatenablog.com/entry/2014/05/30/232911
" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'

" Go に付属の plugin と gocode を有効にする
set rtp^=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
syntax on
au FileType go compiler go
filetype plugin on
let g:go_fmt_command = "goimports"
