syntax on
set tabstop=4
set shiftwidth=4
set number
set hlsearch
set printoptions=number:y,left:10mm
set background=light
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error
let g:localvimrc_persistent=2 " 一度聞いたファイルを記録しておき、次回からは自動で読み込む
hi Pmenu ctermbg=131
hi PmenuSel ctermbg=124

call plug#begin()
Plug 'leafgarland/typescript-vim'
Plug 'jason0x43/vim-js-indent'
Plug '2072/PHP-Indenting-for-VIm'
call plug#end()

let g:js_indent_typescript = 1
au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.h set filetype=c
set noautoindent
set nosmartindent
setlocal indentexpr=
setlocal formatoptions-=r
setlocal formatoptions-=o
