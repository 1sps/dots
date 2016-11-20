"~/.vimrc file
"=============

"___: 2016-01-19 Tue 12:13 AM
"___: 2016-10-08 Sat 06:56 AM
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"BASIC SETTINGS {{{

syntax 		on
set 		tabstop=8
set 		autoindent
set 		number
set		textwidth=80
"set 		numberwidth=4
set 		shiftwidth=8
set 		hlsearch
set 		background=dark
colorscheme     spsold           
"set 		list lcs=tab:\|\ 
set		splitright
set		foldmethod=marker
set		colorcolumn=+1,81
highlight 	ColorColumn ctermbg=232

"}}}

"KEYBINDING (MAPS) {{{

"MAP LEADER
let mapleader = "-"

"__________________________
"MISCELLANIOUS KEY BINDINGS

"EASIER WAY TO ESCAPE FROM INSERT MODE
inoremap 	jk         <Esc>
"TURN OFF HIGHLIGHT
nnoremap 	<leader>n  :nohl<cr>  
"PUT A LINE BELOW THE CURRENT LINE
nnoremap        <leader>l  yypvg_r= 
"TOGGLE LINE NUMBER
nnoremap        <leader>tl :set invnumber<CR>
"EDIT VIMRC IN NEW WINDOW
nnoremap 	<leader>ve :vsplit $MYVIMRC<cr>
"SOURCE LATEST VIMRC
nnoremap 	<leader>vs :source $MYVIMRC<cr>
"PUT CONDITION NAME BESIDE ENDIF IN C/C++ CODE
nnoremap 	<leader>ei ^%wwye%A /* <Esc>pa */<Esc>
"SET RIGHTLEFT
nnoremap 	<silent> <leader>rl :set rightleft!<CR>
"UPDATE UP TIME
nnoremap 	<leader>pu  ^f:wcg_<C-R>=strftime("%Y-%m-%d %a %I:%M %p")
                           \ <CR><Esc>g_
"PASTE TOGGLE
nnoremap 	<silent> <leader>pt  :set paste!<CR>
"PRINT CURRENT TIME
nnoremap	<F3> 	   a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")
                           \ <CR><Esc>g_
inoremap 	<F3> 	   <C-R>=strftime("%Y-%m-%d %a %I:%M %p")
                           \ <CR><Esc><Esc>A
"SHOW BUFFERS AND CHOOSE FROM ONE OF THEM
nnoremap 	<leader>bb 	:buffers<cr>:b<space>
"DISABLE ARROW KEYS, BACKSPACE, DELETE IN NORMAL, INSERT MODES
inoremap 	<Up>		<nop>
inoremap 	<Down>		<nop>
inoremap 	<Left>		<nop>
inoremap 	<Right>		<nop>

nnoremap 	<Up>		<nop>
nnoremap 	<Down>		<nop>
nnoremap 	<Left>		<nop>
nnoremap 	<Right>		<nop>

inoremap 	<BS>		<nop>
nnoremap 	<BS>		<nop>

inoremap 	<Del>		<nop>
nnoremap 	<Del>		<nop>

"JUXTAPOSE TWO WORDS 
nnoremap 	<leader>jx     wdebvepa <Esc>p

"TO PUT AND REMOVE COMMENTS
augroup optype_comment 
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <leader>c I//<esc>
	autocmd FileType python     nnoremap <buffer> <leader>c I# <esc>
	autocmd FileType c          nnoremap <buffer> <leader>c
	                            \ I/* <esc>A */<esc>
	autocmd FileType c          nnoremap <silent> <buffer> <leader>u 
	                            \:s#/\* *\(.*\) *\*/#\1<CR>:nohl<CR>
	autocmd FileType cpp   	    nnoremap <buffer> <leader>c
	                            \ I/* <esc>A */<esc>
	autocmd FileType java 	    nnoremap <buffer> <leader>c
	                            \ I/* <esc>A */<esc>
	autocmd FileType perl 	    nnoremap <buffer> <leader>c I#<esc>
	autocmd FileType html 	    nnoremap <buffer> <leader>c
	                            \ I<!-- <esc>A --><esc>
	autocmd FileType php 	    nnoremap <buffer> <leader>c
	                            \ I/* <esc>A */<esc>
	autocmd FileType php          nnoremap <silent> <buffer> <leader>u 
	                            \:s#/\* *\(.*\) *\*/#\1<CR>:nohl<CR>
augroup END

"}}}

"OPERATOR PENDING REMAPS {{{

" }}}

"ABBREVIATIONS {{{

"COMMON SPELLING MISTAKES 
abbreviate teh the

"JAVA ABB
augroup java_specific
	autocmd!
	autocmd FileType java abbreviate ln System.out.println()
	autocmd FileType java abbreviate
	                 \ psvm public static void main(String[] args)
augroup END

" }}}

"SKELETON TEMPELATES FOR DIFFERENT FILES  {{{ 
augroup optype_skels 
	autocmd!
	"autocmd 	BufNewFile *.sh	  0read ~/.skel/bash.skel
	autocmd 	BufNewFile *.c 	  0read ~/.skel/c.skel
	autocmd 	BufNewFile *.c 	  normal Gddggf*
	autocmd 	BufNewFile *.cpp  0read ~/.skel/cpp.skel
	autocmd 	BufNewFile *.cpp  normal Gddgg
	autocmd 	BufNewFile *.pl   0read ~/.skel/perl.skel
	autocmd 	BufNewFile *.py   0read ~/.skel/python.skel
	autocmd 	BufNewFile *.java 0read ~/.skel/java.skel
	autocmd 	BufNewFile *.java normal Gddgg
augroup END

"}}}

"FUNCTIONS   {{{

"_____________________
"MAKE A BACKUP OF FILE
function! SaveBackup()
	let b:backup_count = exists('b:backup_count') ? b:backup_count+1 : 1
	call writefile(getline(1, '$'), bufname('%') . '_' . b:backup_count) 
	echo "Backup created !"
endfunction
nnoremap <C-B> :call SaveBackup()<CR>

"____________________________________
"PUT STARTING COMMENTS AT TOP OF FILE
function! PutTopComment(fc, ccal, lc) 
	let fc   = a:fc
	let ccal = a:ccal
	let cc   = ccal . " "
	let lc   = a:lc
	let bl   = ""

	let  linenum = 0

	call append(linenum, fc)
	call append(linenum+1, cc . bufname("%") . ":")
	call append(linenum+2, ccal)
	call append(linenum+3, cc . "St: " . strftime("%Y-%m-%d %a %I:%M %p"))
	call append(linenum+4, cc . "Up: " . strftime("%Y-%m-%d %a %I:%M %p"))
	call append(linenum+5, ccal)
	call append(linenum+6, cc . "Author: SPS")
	call append(linenum+7, lc)
	call append(linenum+8, bl)
endfunction
nnoremap <leader>bc :call PutTopComment("##", " #", " ##")<CR>

"_______________________________________
"AUTOCMD TO PUT TOP COMMENT ON NEW FILES
augroup optype_topcmt 
	autocmd!
	autocmd  BufNewFile  *.c    call PutTopComment("/*", " *", " */")
	autocmd  BufNewFile  *.cpp  call PutTopComment("/*", " *", " */")
	autocmd  BufNewFile  *.java call PutTopComment("/*", " *", " */")
	autocmd  BufNewFile  *.sh   call PutTopComment("##", " #", " ##")
	autocmd  BufNewFile  *.py   call PutTopComment("##", " #", " ##")
augroup END

"___________________________
"PRINT A FUNCTION PARAM LIST
function! PrintParams(param_list)
	let cur_ln = 0
	let param_len = len(a:param_list)

	let cur_ln = line('.') 
	call append(cur_ln-1, "/*")
	call append(cur_ln, " *")
	call append(cur_ln, " *")
	call setpos(cur_ln+2, 0)

	for i in range(0, param_len-1)
		let cur_ln = line('.') 
		call append(cur_ln-1, " * @" . a:param_list[i] . ":")
		call setpos(cur_ln-1, 0)
	endfor

	let cur_ln = line('.') 
	call append(cur_ln-1, " */")
	call setpos(cur_ln-1, 0)
endfunction

"____________________________
"PUT FUNCTION HEADING COMMENT

" Check if a line is function start
function! CheckFunc(line)
	if match(a:line, '.*(.*) *{\? *$') == -1
		return 0
	else
		return 1
	endif
endfunction

" Get private brackets
function! GetPrivBrackets(line_num, line, list_item, pos)
	let pos = 0
	let list_item = ""
	let old_len = 0
	let new_len = 0
	let line_num = 0
	let line = ""
	let line_len = 0
	let ret_top = []

	let list_item = a:list_item
	let line_num = a:line_num
	let line = a:line
	let pos = a:pos
	let line_len = strlen(line)

	let list_item = substitute(list_item, '\(.*\)$',
			\ '\1' . line[pos], "g")

	let pos = pos +1

	while line[pos] != ')'
		if line[pos] == '('
			let ret_top = GetPrivBrackets(line_num,line,
			                              \ list_item, pos)
			let list_item = ret_top[0]
			let line_num = ret_top[1]
			let pos = ret_top[2]
			" Empty the list
			call remove(ret_top, 0, 2)
		else
			let list_item = substitute(list_item, '\(.*\)$',
			                \ '\1' . line[pos], "g")
		endif
		let pos = pos + 1
		if pos == line_len
			let list_item = substitute(list_item, '\(.*\)$',
					\ '\1' . ' ', "g")
			let line_num = line_num + 1
			let line = getline(line_num)
			let pos = 0
			let line_len = strlen(line)
		endif
	endwhile
	let list_item = substitute(list_item, '\(.*\)$',
			\ '\1' . line[pos], "g")

	call add(ret_top, list_item)
	call add(ret_top, line_num)
	call add(ret_top, pos)
	return ret_top
endfunction

" Get a comma list
function! GetCommaList(line_num, line, pos)
	let comma_list = []
	let inside_parn = 0
	let pos = 0
	let line_num = 0
	let line = ""
	let old_len = 0
	let new_len = 0
	let list_item = ""
	let ret_top = []
	let line_len = 0

	let line_num = a:line_num
	let line = a:line
	let pos = a:pos
	let line_len = strlen(line)
	while line[pos] != ')'
		if line[pos] == '('
			let ret_top = GetPrivBrackets(line_num, line,
			                                \ list_item, pos)
			let list_item = ret_top[0]
			let line_num = ret_top[1]
			let pos = ret_top[2]
		elseif line[pos] == ','
			call add(comma_list, list_item)
			let list_item = ""
		else
			let list_item = substitute(list_item, '\(.*\)$',
					\ '\1' . line[pos], "g")
		endif
		let pos = pos + 1
		if pos == line_len
			let list_item = substitute(list_item, '\(.*\)$',
					\ '\1' . ' ', "g")
			let line_num = line_num + 1
			let line = getline(line_num)
			let pos = 0
			let line_len = strlen(line)
		endif
	endwhile
	call add(comma_list, list_item)
	return comma_list
endfunction


" Process Private brackets
function! ProcPriv(str)
	let last_priv = ""
	let str = a:str
	let pos = 0
	let len = 0
	let line_num = 0
	let ret_top = []

	" Ignore leading blanks
	let str = substitute(str, '^ \+[^ ]', '', 'g')

	" Ignore trailing blanks
	let str = substitute(str, ' \+$', '', 'g')

	let len = strlen(str)

	"Get to untill comma or `('
	while pos < len && str[pos] != ',' && str[pos] != '('
		let pos = pos + 1
	endwhile

	"Return if no private brackets 
	if pos == len || str[pos] == ','
		let last_priv = ""
		return last_priv
	endif

	" If priv bracket, process the first One
	if str[pos] == '('
		let last_priv = ""
		let ret_top = GetPrivBrackets(line_num, str, last_priv, pos)
		let last_priv = ret_top[0]
	endif

	return last_priv
endfunction

" Get a paramter from a comma block
function! GetParam(str)
	let str = a:str
	let pos = 0
	let st_pos = 0
	let end_pos = 0
	let last_priv = ""
	let param = ""

	" First process if any Priv Brackets
	let last_priv = ProcPriv(str)

	" If any priv brackets, name is the name in latest priv bracket
	if strlen(last_priv) > 0
		echo "Last priv is: " . last_priv
		" Get till start of name
		let pos = 0
		while last_priv[pos] == '(' || 
		      \ last_priv[pos] == ' ' ||
		      \ last_priv[pos] == '*'
			let pos = pos+1
		endwhile
		" Get the name
		while last_priv[pos] != ' ' && last_priv[pos] != ')' &&
		      \ last_priv[pos] != '('
			let param = substitute(param, '\(.*\)$',
					\ '\1' . last_priv[pos], "g")
			let pos = pos + 1
		endwhile
	" Else name is last name
	else
		echo "No Last priv"
		" Ignore trailing blanks
		let str = substitute(str, ' \+$', '', 'g')
		let pos = strlen(str)-1

		while str[pos] != ' ' && str[pos] != '*'
			let param = substitute(param, '\(.*\)$',
					\ str[pos] .  '\1', "g")
			let pos = pos - 1
		endwhile
	endif
	return param
endfunction

" Put function comment in smart way
function! PfcSmart()
	let comma_list = []
	let param_list = []
	let cur_line = ""
	let line_num = 0
	let pos = 0

	" Check if it is _actually_ a function
	let line_num = line(".")
	let pos = col(".")
	let cur_line = getline(".")
	"if CheckFunc(cur_line) == 0
		"echo "Not a function!"
		"return 0
	"endif

	" Get the comma separeted tokens in a list
	let comma_list = GetCommaList(line_num, cur_line, pos)

	" Get params from comma list
	for i in range(0, len(comma_list)-1)
		call add(param_list, GetParam(comma_list[i]))
	endfor

	" Print the params
	call PrintParams(param_list)
endfunction
nnoremap <leader>fd :call PfcSmart()<CR>

" Insert a section separator comment
function! PutSectionSeparator(fc, sc)

	" Prepare strings
	let first_line = a:fc . a:sc
	let last_line = " " . a:sc . a:fc
	let user_line = " " . a:sc . " "
	let long_line = " " . a:sc
	for i in range(0, 78)
		let long_line = substitute(long_line, '\(.*\)$',
		                                  \ '\1' . a:sc, 'g')
	endfor

	" Get line number
	let line_num = line(".") - 1

	" Put first line
	call append(line_num, first_line)
	let line_num = line_num+1

	" Put second line (long line)
	call append(line_num, long_line)
	let line_num = line_num+1

	" Put third line (user comment line)
	call append(line_num, user_line)
	let line_num = line_num+1
	let user_line_num = line_num

	" Put fourth line (long line)
	call append(line_num, long_line)
	let line_num = line_num+1

	" Put last line
	call append(line_num, last_line)

	" Put cursor to user line
	call setpos(".", [0, user_line_num, 3, 0])

endfunction

"________________________________________
"AUTOCMD TO PUT SECTION SEPARATOR COMMENT
augroup optype_secsepcomment 
	autocmd!
	autocmd	BufNewFile,BufRead *.c nnoremap <leader>sc
	                            \ :call PutSectionSeparator("/", "*")<CR>
	autocmd	BufNewFile,BufRead *.cpp nnoremap <leader>sc
	                            \ :call PutSectionSeparator("/", "*")<CR>
	autocmd	BufNewFile,BufRead *.java nnoremap <leader>sc
	                            \ :call PutSectionSeparator("/", "*")<CR>
	autocmd	BufNewFile,BufRead *.py nnoremap <leader>sc
	                            \ :call PutSectionSeparator("#", "#")<CR>
	autocmd	FileType           vim nnoremap <leader>sc
	                            \ :call PutSectionSeparator('"', '"')<CR>
	autocmd	FileType           sh nnoremap <leader>sc
	                            \ :call PutSectionSeparator('#', '#')<CR>
augroup END


" }}}

" WEB-DEV SETTINGS {{{
augroup optype_webdevset
	autocmd!
	autocmd BufNewFile,BufReadPost *.html,*.php,*.css set 	textwidth=150
	autocmd BufNewFile,BufReadPost *.html,*.php,*.css set   tabstop=2
	autocmd BufNewFile,BufReadPost *.html,*.php,*.css set 	expandtab
	autocmd BufNewFile,BufReadPost *.html,*.php,*.css set 	shiftwidth=2
augroup END
"}}}

" NOTES {{{

" Ctrl Commands in Insert mode
"==============================

" Ctrl-r  -> Select the register to paste
" Ctrl-r. -> Select register . which holds last insert text
" Ctrl-a  -> Paste the text inserted in last insert 

" Ctrl-x  -> Puts to completion submode, and you can select
"            from one of the sub-sub mode. 
"            Ctrl-n ->words
"            Ctrl-p ->words
"            Ctrl-t ->tags? 
"            Ctrl-l ->line

" }}}

