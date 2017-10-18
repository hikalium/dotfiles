syntax on
set nocompatible
set backspace=indent,eol,start

"
" Status Line Settings
"

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
set statusline+=:%l
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=\ %Y[%{&fileencoding}]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

highlight Search cterm=NONE ctermfg=black ctermbg=yellow
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=green

au BufNewFile,BufRead *.c set filetype=c
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile,BufRead *.cc set filetype=cpp
au BufNewFile,BufRead *.h set filetype=cpp

set tabstop=4
set shiftwidth=4
au FileType cpp set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set expandtab
au FileType c set tabstop=2
au FileType c set shiftwidth=2
au FileType c set expandtab

au FileType fortran set noexpandtab

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
	Plug 'vim-syntastic/syntastic'
	Plug 'Lokaltog/powerline'
	"Plug 'powerline/powerline'
	"Plug 'justmao945/vim-clang'
	"Plug 'Shougo/neocomplete.vim'
call plug#end()

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
" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'

" Go に付属の plugin と gocode を有効にする
set rtp^=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
syntax on
au FileType go compiler go
filetype plugin on
let g:go_fmt_command = "goimports"

" vim-syntastic/syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" powerline status
"let s:prev_seg = 'paste_indicator'
"for seg in ['fileformat', 'fileencoding', 'filetype', 'lineinfo']
"	call Pl#Theme#InsertSegment(seg, 'after', s:prev_seg)
"	let s:prev_seg = seg
"endfor
"unlet s:prev_seg
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["html"] }
let g:syntastic_cpp_compiler_options=" -std=c++1z"

function! CPPCodeCleanup()
  echo "Cleanup cpp code"
  let l:lines="all"
  let g:clang_format_fallback_style = 'Google'
  :pyf /usr/local/share/clang/clang-format.py
endfunction
command! CPPCodeCleanup call CPPCodeCleanup()

autocmd BufWrite *.{cpp} :CPPCodeCleanup
autocmd BufWrite *.{cc} :CPPCodeCleanup
autocmd BufWrite *.{hpp} :CPPCodeCleanup
autocmd BufWrite *.{c} :CPPCodeCleanup
autocmd BufWrite *.{h} :CPPCodeCleanup

if $TMUX != ""
	augroup titlesettings
		autocmd!
		autocmd BufEnter * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
		autocmd VimLeave * call system("tmux rename-window bash")
		autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
	augroup END
endif

autocmd BufWritePost *.{tex} :!make

set wildmode=list:longest

