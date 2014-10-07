Markdown Auto-Indent
====================

Indent-parsing for markdown syntax.

Defines and sets a function for `indentexpr`; a more sophisticated and
filetype-specific method of determining the correct indentation-level
than `cindent` (for C syntax, clue in the name) and `smartindent` (for
everything else). 


Rationale
---------

For a long time I put up with Vim's `smartindent` feature for my
auto-indentation needs. After too much time spent fighting various
cases (particularly lists in markdown) I've since seen the error of my
ways and now use filetype-based indenting. The only issue here is that
a function needs to be designed to allow Vim to determine the correct
indentation.

[vim-markdown][] does provide one but as far as I could tell it
doesn't work. I bit the bullet and started throwing one together
myself based on that as a starting point.

It's early days, but so far the clouds have parted and rays of shiny
indenty light are now illuminating my Vim writing experience. Not only
does this make things more pleasant to work with it helps [pandoc][]
parse correctly.


Install
-------

This is going to be pretty terse and a little bit RTFM as there are
multiple things in play here, but basically:

 1.	Copy/symlink `indent/markdown.vim` into a directory where vim can
	find it. For example:

		~/.vim/indent/markdown.vim
		~/.vim/after/indent/markdown.vim

	(yes, I know, I'll ensure this is bundle-friendly ASAP).

 2.	Ensure that filetype indenting is on. This might involve something
 	like the following in `~/.vimrc`:
 
 		filetype indent on			" or...
		filetype plugin indent on	" etc.
	
 3.	The docs reckon setting `indentexpr` (which is what this does)
	will override `smartindent`, but I've not looked into this. 

YMMV.


Usage/Features
--------------

Well, it's `autoindent`. Everything should probably just work as long
as everything is set up right (see `:help fo-table` for tweaks). 

Some notes:

  - Markdown allows you to write lazy lists. This corrects them (if
	you manage to make them in the first place!).
  -	It tries to be sensible about what it indents. For example: 2+
	blank lines are considered to be a semantic break so it won't try
	and fix the indent. I'm sure other cases have slipped through the
	net.
  -	So far, all the [canonical list examples][daringfireball] seem to
	check out. I don't know how nested blockquotes and code blocks
	work but they do; I've not checked nested lists.


TODO
----

  - Make sure this works with [Pathogen][] and [Vundle][].
  - Pandoc list-like extensions.


[daringfireball]: http://daringfireball.net/projects/markdown/syntax
[vundle]: https://github.com/gmarik/Vundle.vim
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-markdown]: https://github.com/plasticboy/vim-markdown
[pandoc]: http://johnmacfarlane.net/pandoc/

