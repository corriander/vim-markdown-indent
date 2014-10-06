" Derived from PlasticBoy's indent file in the vim-markdown project.
" Extends beyond regular markdown syntax to include Pandoc.
"
" Definition guard; abort if this is already done
if exists("b:did_indent") | finish | endif
let b:did_indent = 1

" indentexp is the heart of this, the function returns the indent
setlocal indentexpr=GetPDMIndent()

setlocal nolisp			" lisp indent overrides, cancel it
setlocal nosmartindent	" not sure this is necessary
setlocal autoindent		

" Only define the function once
if exists("*GetPDMIndent") | finish | endif

" Functions {{{1
function! s:is_line_start(line)
    return a:line !~ '^ *\([*-]\)\%( *\1\)\{2}\%( \|\1\)*$' &&
      \    a:line =~ '^\s*[*+-] \+'
endfunction

function! s:is_blank_line(line)
    return a:line =~ '^$'
endfunction

function! s:last_nonblank_line(line)
    let i = a:lnum
    while i > 1 && s:is_blank_line(getline(i))
        let i -= 1
    endwhile
    return i
endfunction

function GetPDMIndent()
    let list_ind = 4
    " Find a non-blank line above the current line.
    let lnum = last_nonblank_line(v:lnum - 1)
    " At the start of the file use zero indent.
    if lnum == 0 | return 0 | endif
    let ind = indent(lnum)
    let line = getline(lnum)    " Last line
    let cline = getline(v:lnum) " Current line
    if s:is_line_start(cline) 
        " Current line is the first line of a list item, do not change indent
        return indent(v:lnum)
    elseif s:is_line_start(line)
        " Last line is the first line of a list item, increase indent
        return ind + list_ind
    else
        return ind
    endif
endfunction
" }}}

" vim: foldmethod=marker
