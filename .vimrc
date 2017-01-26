syntax on
set tabstop=4
set shiftwidth=4
set number
set hlsearch
set printoptions=number:y,left:10mm
set background=light
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error
let g:localvimrc_persistent=2 " 一度聞いたファイルを記録しておき、次回からは自動で読み込む
