# tutorial-tkdocs

Using Ruby, I followed
[this tutorial](https://tkdocs.com/tutorial/index.html)
from
[tkdocs.com](https://tkdocs.com/index.html).
It gives a beautiful introduction to the Tk graphics library.

Taking all of the tutorial examples (in Ruby code),
I rewrote them into a style I would use in production.
(However, each example still completely fits within a single file.)
They are arranged by tutorial chapter.

In the rewrite, I used
[Hungarian notation](https://en.wikipedia.org/w/index.php?oldid=870041230&title=Hungarian_notation)
for all of the object instances derived from Tk classes.
This was in order to distinguish the Tk objects clearly from any other objects or identifiers.
For a table presenting the prefixes, see
[other/hungarian-notation.txt](other/hungarian-notation.txt).

Tested using Tk 8.5.12 and Ruby 2.2.5, on Windows 7.

## See also

The
[Tcl/Tk 8.5 Commands](http://www.tcl.tk/man/tcl8.5/TkCmd/contents.htm)
documentation.

The Ruby developer
[code examples](https://github.com/ruby/ruby/tree/ruby_2_2/ext/tk/sample)
for using Tk.

My repository [try-tk](https://github.com/MarkDBlackwell/try-tk) (which is obsolete).

Copyright (c) 2019 Mark D. Blackwell.

License: MIT
