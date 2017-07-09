"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin
"ファイルを開くと発動します）

function! s:convToBinaryPre(bin)
	if &binary
		%!xxd -r
	endif
endfunction

function! s:convToBinary(bin)
	if &binary
		silent %!xxd -g 1
		set nomod
	endif
endfunction

augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * call s:convToBinaryPre(&binary)
	autocmd BufWritePost * call s:convToBinary(&binary)
augroup END
