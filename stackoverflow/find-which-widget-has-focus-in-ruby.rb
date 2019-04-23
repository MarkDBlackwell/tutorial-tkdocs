# See:
#  http://stackoverflow.com/questions/55567159/find-which-widget-has-focus-in-ruby-2-3-3

require 'tk'

def focus_array
  @focus_array ||= [
      f_content, e_content,
      to_one,    e_one,
      to_two,    e_two,
      ]
end

def focus_array_class_width_max
  @focus_array_class_width_max ||= focus_array.map {|e| e.class.to_s.length}.max
end

def focus_delay
  milliseconds = 1000
  Tk.after milliseconds, lambda_focus_rotate
  nil
end

def focus_force(object)
  force = true
  Tk.focus_to object, force
  nil
end

def focus_print
  path = Tk.focus.path
  index = focus_array.find_index {|e| e.path == path}
  s = klass_justified index
  puts "Item #{index}'s class and path are:  #{s}  #{path}"
  nil
end

def focus_rotate
  @counter += 1
  index = @counter % focus_array.length
  puts '' if 0 == index
  focus_force focus_array.at index
  nil
end

def klass_justified(index)
  focus_array.at(index).class.to_s.ljust focus_array_class_width_max
end

def lambda_focus_rotate
  @lambda_focus_rotate ||= Kernel.lambda do
    focus_rotate
    focus_print
    focus_delay
  end
end

def main
  root.title = 'Root'
  objects_create
  @counter = -1 # Start before first.
  focus_delay
  Tk.mainloop
  nil
end

def objects_create
# Keep order:
  e_content
  e_one
  e_two
  nil
end

def spacing_set(object)
  object.width 7
  object.grid padx: 40
end

#-------------
# Tk objects:

def e_content
  @e_content ||= begin
    e = Tk::Tile::Entry.new f_content
    spacing_set e
  end
end

def e_one
  @e_one ||= begin
    e = Tk::Tile::Entry.new to_one
    spacing_set e
  end
end

def e_two
  @e_two ||= begin
    e = Tk::Tile::Entry.new to_two
    spacing_set e
  end
end

def f_content
  $f_content ||= begin
    f = Tk::Tile::Frame.new root
    f.grid
  end
end

def root
  $root ||= TkRoot.new
end

def to_one
  @to_one ||= TkToplevel.new f_content
end

def to_two
  @to_two ||= TkToplevel.new f_content
end

main
