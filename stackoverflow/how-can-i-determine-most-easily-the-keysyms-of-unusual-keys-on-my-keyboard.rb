# coding: utf-8

# See:
#  http://stackoverflow.com/questions/55602789/how-can-i-determine-most-easily-the-keysyms-of-unusual-keys-on-my-keyboard-in-r

require 'tk'

def lambda_keypress
  @lambda_keypress ||= Kernel.lambda do |key_code, key_symbol|
    puts "lambda_keypress invoked with keycode #{key_code} and keysym #{key_symbol}."
  end
end

def root
  $root ||= begin
    Tk::Encoding.encoding = ''.encoding
    TkRoot.new
  end
end

root.bind :KeyPress, lambda_keypress, '%k %K'
Tk.mainloop
