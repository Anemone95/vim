" noremap    <buffer>  <silent>  <LocalLeader>rr         :w<enter>:!python %<enter>
 " map  <buffer>  <silent>  <F9>       :w<CR>:!python %<CR>
" imap  <buffer>  <silent>  <F9>  <C-C>:w<CR>:!python %<CR>
"map <C-i> ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<cr><esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
"autocmd BufNewFile ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<esc>:r !date <esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
vmap <F2> <c-v>I#<esc>
vmap <F3> <c-v>x
vmap <Tab> <c-v>I<Tab><Esc>
nmap <C-i> :call LoadTemplate("main.py")<CR>
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIMFILES."/py-support/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
    sil! execute "%s/<FILENAME>/".expand("%:t")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
	"sil! execute "%s/<DATE>/"."hello"."/g"
    call search("<CU","W")
    sil! execute "normal \"adf>"
    sil! execute "startinsert!"
    "call TemplateReplTags()
endfunction
function! LoadClass(filename)
    "let s:test=input("Please input:")
    let s:classname=Input("CLASS NAME:","")
    if s:classname!=""
        sil! exec "0r ".$VIMFILES."/py-support/".a:filename
	    sil! exec "%s/<CLASSNAME>/".s:classname."/g"
        call search("<CU","w")
        sil! execute "normal \"adf>"
        sil! execute "startinsert!"
    endif
endfunction
function! LoadFun()
    "let s:test=input("Please input:")
    let s:funname=Input("FUNCTION NAME:","")
    if s:funname!=""
        "sil! exec "0r ".$VIMFILES."/py-support/".a:filename
	    sil! exec "%s/<FUNCTIONNAME>/".s:funname."/g"
        call search("<CU","w")
        sil! execute "normal \"adf>"
        sil! execute "startinsert!"
    endif
endfunction
function! Input ( promp, text, ... )
	echohl Search														" highlight prompt
	call inputsave()											" preserve typeahead
	if a:0 == 0
		let retval	=input( a:promp, a:text )
	else
		let retval	=input( a:promp, a:text, a:1 )
	endif
	call inputrestore()									" restore typeahead
	echohl None														" reset highlighting
	let retval  = substitute( retval, '^\s\+', "", "" )		" remove leading whitespaces
	let retval  = substitute( retval, '\s\+$', "", "" )		" remove trailing whitespaces
	return retval
endfunction    " ----------  end of function C_Input ----------
noremap    <buffer>  <silent>  <LocalLeader>if <esc>odef <FUNCTIONNAME>():<CR><CURSOR><esc>:call LoadFun()<CR>
imap    <buffer>  <silent>  <LocalLeader>if <esc>odef <FUNCTIONNAME>():<CR>"docstring for <FUNCTIONNAME><esc>o<CURSOR><esc>:call LoadFun()<CR>
noremap    <buffer>  <silent>  <LocalLeader>ic :call LoadClass("class.py")<CR>
imap    <buffer>  <silent>  <LocalLeader>ic <esc>o<esc>:call LoadClass("class.py")<CR>
if line("$")==1
    call LoadTemplate("main.py")
endif
