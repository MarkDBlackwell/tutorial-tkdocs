=begin
See:
  http://stackoverflow.com/questions/2645671/embedding-tcl-in-ruby
  http://www.thecodingforums.com/threads/run-tcl-in-ruby.818976/#post-4454838

To make it work, I needed to duplicate the following directories:

1. /c/Ruby/lib/tcltk/tcl8.5  as  /c/Ruby/lib/tcl8.5
2. /c/Ruby/lib/tcltk/tk8.5   as  /c/Ruby/lib/tk8.5
=end

#-------------
require 'tcltklib'

def test
  ip1 = TclTkIp.new

  puts ip1._eval('button .lab -text exit -command "destroy ."').inspect
  puts ip1._eval('pack .lab').inspect

  puts ip1._eval(%q+puts [ruby {print "print by ruby\n"; 'puts by tcl/tk'}]+).inspect

  TclTkLib.mainloop
end

test


#-------------
require 'tcltklib'

def test
# nil, false means without Tk:
  ip1 = TclTkIp.new nil, false

  puts ip1._eval('list { aa bb cc }').inspect

  puts ip1._eval('set list { aa bb cc }; join $list ""').inspect

  TclTkLib.mainloop
end

test
