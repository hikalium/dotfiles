" hikalium Config for NVIM v0.11.3
"
" Setup Commands:
" (shell)
" ~/dotfiles/scripts/setup_nvim_linux.sh
" source ~/.bashrc
" (nvim)
" :PlugInstall
"
" Debug guide
" To print all options with non-default value, run:
"   :set!
" To see LSP capabilities, run:
"   :lua =vim.lsp.get_clients()[1].server_capabilities

call plug#begin()
  Plug 'neovim/nvim-lspconfig'
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'
  Plug 'luochen1990/rainbow'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
call plug#end()

lua << EOF

vim.o.winborder = 'single'

vim.lsp.config('rust_analyzer', {
    on_attach = function(client, bufnr)
            --local mode = vim.api.nvim_get_mode().mode
            vim.defer_fn(function()
            vim.lsp.inlay_hint.enable(true)
            end, 5000)
    end,
    cmd = {os.getenv("HOME").."/.cargo/bin/rust-analyzer"},
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            },
            check = {
                ["allTargets"] = false
            },
            checkOnSave = true,
        }
    },
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}),
        ["textDocument/codeLens"] = vim.lsp.with(vim.lsp.handlers.code_lens, {border = "single"}),
        ["textDocument/completion"] = vim.lsp.with(vim.lsp.handlers.completion, {border = "single"}),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"}),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {border = "single"}),
        ["signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"}),
    },
})
vim.lsp.enable('rust_analyzer')

vim.diagnostic.config({
virtual_text = { prefix = '<< ' },
    signs = true,
    underline = false,
    float = { border = "single" }
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'X',
            [vim.diagnostic.severity.WARN]  = '!',
            [vim.diagnostic.severity.INFO]  = '>',
            [vim.diagnostic.severity.HINT]  = '?',
        }
    }
})

  -- Set up nvim-cmp.
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      -- Specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
        completion = {
            completion = {
                border = "single",
                winhighlight = "Normal:CmpNormal",
            }
        },
        documentation = {
            documentation = {
                border = "single",
                winhighlight = "Normal:CmpNormal",
            }
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<ESC>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.confirm()
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

-- Completion Menu Navigation
vim.keymap.set('i', '<Tab>', function(fallback)
    if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    else
        return "<Tab>"
    end
end)
vim.keymap.set('i', '<S-Tab>', function(fallback)
    if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    else
        return "<S-Tab>"
    end
end)

EOF

autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})

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
"set complete=Fvsnip#completefunc

" keep moving to next / prev lines
" when hit the end of lines (with cursor keys)
set whichwrap+=<,>

" Coc.nvim
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

" DiagnosticSign* - mar
hi DiagnosticSignError    guifg=#000000 guibg=#ff8080
hi DiagnosticSignWarn     guifg=#000000 guibg=#ffdd88
hi DiagnosticSignInfo     guifg=#ffffff guibg=#6d85ff
hi DiagnosticSignHint     guifg=#000000 guibg=#6dff85
hi DiagnosticSignOk       guifg=#ffffff guibg=NONE

hi DiagnosticError  guifg=#ff8080 guibg=#454545
hi DiagnosticWarn   guifg=#ffdd88 guibg=#454545
hi DiagnosticInfo   guifg=#6d85ff guibg=#454545
hi DiagnosticHint   guifg=#6dff85 guibg=#454545

hi LineNr           guifg=#aaaaaa guibg=#002000
hi StatusLine       guifg=#ffffff guibg=#008000
hi StatusLineNC     guifg=#ffffff guibg=#004000
hi TabLineFill      guifg=NONE    guibg=NONE
hi Visual           guifg=#000000 guibg=#cccc60
hi ErrorMsg         guifg=#ffff80 guibg=#ff0000


hi! link DiagnosticFloatingError    LiumRedText
hi! link DiagnosticFloatingHint     LiumGreenText
hi! link DiagnosticFloatingWarn     LiumYellowText

hi! link Comment                    LiumRedText
hi! link Conditional                LiumYellowText
hi! link Constant                   LiumGreenText
hi! link Delimiter                  LiumGreenText
hi! link Function                   LiumBlueText
hi! link Identifier                 LiumWhiteText
hi! link Operator                   LiumGreenText
hi! link PreProc                    LiumRedText
hi! link rustKeyword                LiumGreenText
hi! link Special                    LiumYellowText
hi! link Statement                  LiumBlueText
hi! link String                     LiumRedText
hi! link Title                      LiumGreenText
hi! link Type                       LiumBlueText
hi! link @variable                  LiumPurpleText

hi! link TabLine        TabLineFill
hi! link Todo           DiagnosticHint

hi! NormalFloat             guifg=#dadada guibg=#454545
hi! CmpNormal               guifg=#dadada guibg=#454545
hi! CmpItemAbbr             guifg=#dadada guibg=#454545
hi! CmpItemAbbrDeprecated   guifg=#dadada guibg=#454545
hi! CmpItemMenu             guifg=#dadada guibg=#454545
hi! CmpItemKind             guifg=#dadada guibg=#454545
hi! Pmenu                   guifg=#dadada guibg=#454545
hi! PMenuSel                guifg=#6ef8be guibg=#454545

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
    set shiftwidth=4 softtabstop=4 expandtab
    set textwidth=80
    set formatoptions=
    hi ColorColumn guifg=NONE guibg=NONE
    au FileType txt,markdown call HighlightOveflowColumn()
augroup END

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
set background=light
let g:localvimrc_persistent=2 " save whether trusted or not

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

au FileType go AutoFormatBuffer gofmt

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

au FileType javascript set tabstop=2
au FileType javascript set shiftwidth=2
au FileType javascript set expandtab

au FileType typescript set tabstop=2
au FileType typescript set shiftwidth=2
au FileType typescript set expandtab

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

function! s:RustConfigs()
    syntax enable
    filetype plugin indent on
    au BufWritePre *.rs lua vim.lsp.buf.format()
endfunction
au FileType rust call s:RustConfigs()

augroup END

"let s:ir_signals_path = '/Users/hikalium/repo/remo-ir-signals/'
"let s:send_sh_path = s:ir_signals_path . '/send.sh'
"let s:on_json_path = s:ir_signals_path . 'on.json'
"let s:off_json_path = s:ir_signals_path . 'off.json'
"command! TurnOnLight
"\ execute ':silent !' . s:send_sh_path . ' ' . s:on_json_path |
"\ execute ':redraw!'
"command! TurnOffLight
"\ execute ':silent !' . s:send_sh_path . ' ' . s:off_json_path |
"\ execute ':redraw!'

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

