# See:
#  http://stackoverflow.com/questions/27705011/close-the-tk-window-using-ruby

require 'tk'

root = TkRoot.new
root.title = "Window"

msgBox = Tk.messageBox(
  'type'    => "okcancel",  
  'icon'    => "info", 
  'title'   => "Framework",
  'message' => "This is message"
)
if 'ok' == msgBox
  root.destroy
  Kernel.exit
end
Tk.mainloop
