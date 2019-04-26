# See:
#   http://stackoverflow.com/questions/38671827/is-there-a-global-variable-set-for-ruby/

require 'tk'

$root = TkRoot.new
$frame1 = Tk::Tile::Frame.new $root

check_buttons = []
info = %w[orange apple banana grape watermelon]
info.each_with_index do |inf,index|
  global_name = "$var#{index}"

  cb = Tk::Tile::CheckButton.new $frame1
  cb.text "#{inf}"
  cb.onvalue "#{inf}"

  create_global = "#{global_name} = TkVariable.new ''"
  Module.module_eval create_global

  assign_value = "#{global_name}.value = '#{inf}'"
  Module.module_eval assign_value

  connect_variable = "cb.variable #{global_name}"
  Module.module_eval connect_variable

  check_buttons.push cb
end

p Kernel.global_variables.select {|e| e.id2name.start_with? '$var'}
p info.length.times.map {|i| Module.module_eval "$var#{i}.value"}
p check_buttons.map {|e| (e.cget :variable).value}

Tk.mainloop
