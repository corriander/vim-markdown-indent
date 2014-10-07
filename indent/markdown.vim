" Derived from PlasticBoy's indent file in the vim-markdown project.
" Extends beyond regular markdown syntax to include Pandoc.
"
" Definition guard; abort if this is already done
if exists("b:did_indent") | finish | endif
let b:did_indent = 1

" indentexp is the heart of this, the function returns the indent
setlocal indentexpr=GetPDMIndent(v:lnum)

setlocal nolisp			" lisp indent overrides, cancel it
setlocal nosmartindent	" not sure this is necessary
setlocal autoindent		

" Only define the function once
if exists("*GetPDMIndent") | finish | endif

let s:LISTINDENT = 4  " TODO: Consider implications of changing this.
let s:NOCHANGE = -1   " indentexpr value of -1 means no-op.

" Functions {{{1

" Line type checks {{{2
" Returns boolean
function! s:is_list_item_head(line)
	let s:pattern_list_item_head = '^\s*[*+-] \+'
    return a:line =~ s:pattern_list_item_head
endfunction

" Returns boolean
function! s:is_blank_line(line)
    return a:line =~ '^$'
endfunction
" 2}}

" Big Daddy {{{2
function GetPDMIndent(lnum)
    " Find the nearest non-blank line before the current one.
    let plnum = prevnonblank(a:lnum - 1)

	if plnum == 0
		" This is the first non-empty line, do not indent.
		return 0
	endif

	if (a:lnum - plnum) > 2
		" Assume more than one blank line is a semantic break, leave
		" the indentation alone
		return s:NOCHANGE
	endif

	" If we got this far, we need to look a little closer
	let current_line = getline(a:lnum)
	let previous_nbline = getline(plnum)		" previous non-blank

	" Checking whether we are in a list
	if s:is_list_item_head(current_line)
		" Do not change the indentation, assume it is as intended
		return s:NOCHANGE
	endif

	if s:is_list_item_head(previous_nbline)
		" Indent according to constant value
		return s:LISTINDENT " TODO: nested lists?
	endif

	" Otherwise, leave indentation up to the user.
	return s:NOCHANGE
endfunction
" 2}}}
" }}}

" vim: foldmethod=marker
