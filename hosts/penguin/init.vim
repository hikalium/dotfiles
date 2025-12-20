" hikalium Config for NVIM v0.11.3
"
" Setup Commands:
" (shell)
" ~/dotfiles/scripts/setup_nvim_linux.sh
" source ~/.bashrc
" (nvim)
" :PlugInstall
" :CocInstall coc-rust-analyzer
" :CocInstall coc-tsserver

call plug#begin()
  Plug 'neovim/nvim-lspconfig'
  Plug 'folke/neoconf.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rust-lang/rust.vim'
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'
  Plug 'brenoprata10/nvim-highlight-colors'
call plug#end()

" lua require("neoconf").setup({})

lua require('nvim-highlight-colors').setup({})

syntax on

set nocompatible
set backspace=indent,eol,start
set wildignore+=*.pdf,*.o,*.obj,*.jpg,*.png
set splitbelow
set splitright
set tabstop=4
set shiftwidth=4
set autoread
set mouse=

" keep moving to next / prev lines
" when hit the end of lines (with cursor keys)
set whichwrap+=<,>

" Coc.nvim
" https://github.com/neoclide/coc.nvim
set cmdheight=2
set updatetime=300

" Status Line Settings
set statusline=
set statusline+=%F " Show full file path
"set statusline+=%f " Show raw file path
set statusline+=%m " Show modification
set statusline+=%r " Show if readonly
set statusline+=%h " Show if help
set statusline+=%w " Show if preview
set statusline+=:%l " Show line number
set statusline+=%= " align right after this
set statusline+=\ %Y[%{&fileencoding}] " file encoding
"set statusline+=%{coc#status()} " LSP status

" Show status line (0:never, 1:two or more windows, 2:always)
set laststatus=2

set guicursor=i:block
set noshowcmd
set langmenu=none
" language en_US

" Hightlight tab chars
set list
set listchars=tab:>_



" **** Colorscheme settings ****
" To dump hi config, run:
" :enew|pu=execute('hi')
" - StatusLine: bottom line

hi clear
set termguicolors
set background=dark

hi Normal           guifg=#ffffff guibg=#002000 guisp=#ff0000 gui=NONE

hi LiumUnknown      guifg=#ff0000 guibg=#00ff00
hi LiumRedText      guifg=#fc7575 guibg=NONE
hi LiumYellowText   guifg=#e9ff81 guibg=NONE
hi LiumGreenText    guifg=#6ef8be guibg=NONE
hi LiumBlueText     guifg=#6da5ff guibg=NONE
hi LiumPurpleText   guifg=#c481ff guibg=NONE
hi LiumWhiteText    guifg=#ffffff guibg=NONE

hi CocInlayHint     guifg=#205020 guibg=NONE
hi CocMenuSel       guifg=NONE    guibg=#fc7575
hi CocSearch        guifg=#ffffff guibg=#5dff20
hi DiagnosticError  guifg=#000000 guibg=#ff8080
hi DiagnosticHint   guifg=#000000 guibg=#6dff85
hi DiagnosticInfo   guifg=#ffffff guibg=#6d85ff
hi DiagnosticWarn   guifg=#000000 guibg=#ffdd88
hi LineNr           guifg=#aaaaaa guibg=#002000
hi NormalFloat      guifg=#ffffff guibg=#5d8020
hi StatusLine       guifg=#ffffff guibg=#008000
hi StatusLineNC     guifg=#ffffff guibg=#004000
hi TabLineFill      guifg=NONE    guibg=#004000
hi Visual           guifg=#000000 guibg=#cccc60
hi ErrorMsg         guifg=#ffff80 guibg=#ff0000
hi CocErrorHighlight gui=underline guisp=#ff0000

hi! link CocFloating    NormalFloat
hi! link CocPumDetail   NormalFloat
hi! link Comment        LiumRedText
hi! link Conditional    LiumYellowText
hi! link Constant       LiumGreenText
hi! link Delimiter      LiumGreenText
hi! link Function       LiumBlueText
hi! link Identifier     LiumWhiteText
hi! link Operator       LiumGreenText
hi! link PreProc        LiumRedText
hi! link rustKeyword    LiumGreenText
hi! link Special        LiumYellowText
hi! link Statement      LiumBlueText
hi! link String         LiumRedText
hi! link TabLine        TabLineFill
hi! link Title          LiumGreenText
hi! link Type           LiumBlueText
hi! link @variable      LiumPurpleText
hi! link Todo           DiagnosticHint

" Not sure where...
"hi! link CursorLine LiumUnknown
"hi! link VertSplit LiumUnknown

"hi cssAttr guifg=#6de5ff guibg=NONE
"hi cssClassNameDot guifg=#c481ff guibg=NONE
"hi cssClassName guifg=#c481ff guibg=NONE
"hi cssColor guifg=#e9ff81 guibg=NONE
"hi cssIdentifier guifg=#fc7575 guibg=NONE
"hi cssImportant guifg=#fc7575 guibg=NONE
"hi cssIncludeKeyword guifg=#6ef8be guibg=NONE

"hi CursorLineNR guifg=#e9ff81 guibg=NONE
"hi Debug guifg=#e9ff81 guibg=NONE
"hi Define guifg=#e9ff81 guibg=NONE
"hi DiffAdd guifg=#6ef8be guibg=NONE
"hi DiffChange guifg=#e9ff81 guibg=NONE
"hi DiffDelete guifg=#fc7575 guibg=NONE
"hi DiffText guifg=#fc7575 guibg=NONE
"hi Directory guifg=#c481ff guibg=NONE
"hi Error guifg=#fc7575 guibg=NONE
"hi ErrorMsg guifg=#fc7575 guibg=NONE
"hi Exception guifg=#fc7575 guibg=NONE
"hi GitGutterAdd guifg=#6ef8be guibg=NONE
"hi GitGutterChangeDelete guifg=#fc7575 guibg=NONE
"hi GitGutterChange guifg=#e9ff81 guibg=NONE
"hi GitGutterDelete guifg=#fc7575 guibg=NONE
"hi Include guifg=#c481ff guibg=NONE
"hi IncSearch guifg=#e9ff81 guibg=NONE
"hi javaScriptBoolean guifg=#c481ff guibg=NONE
"hi Keyword guifg=#6ef8be guibg=NONE
"hi Label guifg=#e9ff81 guibg=NONE
"hi Macro guifg=#e9ff81 guibg=NONE
"hi markdownLinkText guifg=#c481ff guibg=NONE
"hi MatchParen guifg=#e9ff81 guibg=NONE
"hi MoreMsg guifg=#e9ff81 guibg=NONE
"hi NonText guifg=#c481ff guibg=#272935
"hi Number guifg=#e9ff81 guibg=NONE
"hi Pmenu guifg=#dadada guibg=#454545
"hi PMenuSel guifg=#6ef8be guibg=NONE
"hi PreCondit guifg=#e9ff81 guibg=NONE
"hi Repeat guifg=#6ef8be guibg=NONE
"hi Search guibg=#c481ff guifg=#dadada
"hi SignColumn guibg=#272935
"hi SpecialChar guifg=#e9ff81 guibg=NONE
"hi SpecialComment guifg=#c481ff gui=none guibg=NONE
"hi Storage guifg=#c481ff guibg=NONE
"hi Tag guifg=#e9ff81 guibg=NONE
"hi Todo guifg=#e9ff81 guibg=NONE
"hi WarningMsg guifg=#fc7575 guibg=NONE

augroup HighlightTrailingSpaces
        autocmd!
        autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=red ctermbg=197
        autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

fun HighlightOveflowColumn()
    set cc=+1,+2,+3,+4  " highlight three columns after 'textwidth'
    hi ColorColumn guifg=NONE guibg=#000000
endfun

augroup AutoHighlightOverflowColumn
    autocmd!
    let g:rust_recommended_style = 0
    set shiftwidth=4 softtabstop=4 expandtab
    set textwidth=80
    set formatoptions=
    hi ColorColumn guifg=NONE guibg=NONE
    au FileType txt,markdown call HighlightOveflowColumn()
augroup END

"hi CocErrorSign ctermfg=191 ctermbg=NONE
"hi CocInfoSign ctermfg=191 ctermbg=NONE
"hi CocWarningSign ctermfg=191 ctermbg=black
"
"hi FgCocErrorFloatBgCocFloating ctermfg=9
"hi FgCocHintFloatBgCocFloating ctermfg=4
"
"hi MatchParen ctermbg=4
"hi NonText term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
"hi Pmenu ctermbg=191
"hi PmenuSel ctermbg=124
""hi Comment ctermfg=191
"hi Search cterm=NONE ctermfg=black ctermbg=191
"hi SpecialKey ctermfg=23 ctermbg=NONE
"hi StatusLine cterm=NONE gui=NONE ctermfg=white ctermbg=22
"hi TabLineSel ctermfg=230 ctermbg=166
"hi VertSplit term=NONE cterm=NONE ctermfg=22 ctermbg=NONE
"hi Visual cterm=NONE ctermfg=black ctermbg=191
"hi SpecialKey ctermfg=23
"hi SignColumn ctermbg=NONE
"
"hi markdownH1 ctermfg=DarkRed ctermbg=NONE
"hi markdownH1Delimiter ctermfg=DarkRed ctermbg=NONE
"hi markdownH2 ctermfg=DarkGreen ctermbg=NONE
"hi markdownH2Delimiter ctermfg=DarkGreen ctermbg=NONE
"hi markdownH3 ctermfg=DarkBlue ctermbg=NONE
"hi markdownH3Delimiter ctermfg=DarkBlue ctermbg=NONE
"hi markdownCodeBlock ctermfg=cyan

" luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
        \       'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \       'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
        \       'operators': '_,_',
        \       'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \       'separately': {
        \               '*': {},
        \               'tex': {
        \                       'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
        \               },
        \               'lisp': {
        \                       'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
        \               },
        \               'vim': {
        \                       'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
        \               },
        \               'html': {
        \                       'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
        \               },
        \               'css': 0,
        \       }
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
        " let fname = pathshorten(bufname(curbufnr))
        let fname = bufname(curbufnr)

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
set formatoptions=

" golang
" http://pandazx.hatenablog.com/entry/2014/05/30/232911
" use goimports instead of gofmt on :Fmt
let g:gofmt_command = 'goimports'

" Enable plugin and gocode
set rtp^=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
au FileType go compiler go
filetype plugin on
let g:go_fmt_command = "goimports"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Disable rust.vim 's rustfmt on save.
" coc-rust-analyzer handles the format better.
let g:rustfmt_autosave = 0
let g:rustfmt_command = 'cargo fmt'

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
nnoremap ce :vsplit $MYVIMRC<CR>
" Reload vims configuration file
" Esc + "confr" will reload the config
nnoremap cr :source $MYVIMRC<CR>

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

augroup hikalium
  " Remove all au in this group first
  " when re-loaded
  autocmd!

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
au FileType markdown set nofoldenable
au FileType markdown set complete=.,w,t
au FileType markdown let b:coc_suggest_disable = 1
"au FileType markdown au BufWritePost <buffer> silent! execute "!cd /home/hikalium/repo/wasabi_book/manuscript_os/ajimi/ && cargo run -- fix %:p" | redraw!

au FileType javascript set tabstop=2
au FileType javascript set shiftwidth=2
au FileType javascript set expandtab
"au FileType javascript noremap <buffer> = :ClangFormat<cr>

au FileType typescript set tabstop=2
au FileType typescript set shiftwidth=2
au FileType typescript set expandtab
"au FileType typescript noremap <buffer> = :ClangFormat<cr>

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

augroup END

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


" Hit enter to select suggestion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" move vertical visually (for soft-wrapped long lines)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Check file update more frequently
if has("autocmd")
  augroup vimrc-checktime
    autocmd!
    autocmd InsertEnter,WinEnter * checktime
  augroup END
endif




" Load ~/.config/nvim/lua/init.lua
if filereadable("~/.config/nvim/lua/init.lua")
  lua require('init')
endif
