# coding: utf-8

# See:
#  http://stackoverflow.com/questions/55602789/how-can-i-determine-most-easily-the-keysyms-of-unusual-keys-on-my-keyboard-in-r

require 'tk'

module ::KeypressCapture
  module GraphicalHelper

    def root
      $root ||= begin
        ::Tk::Encoding.encoding = ''.encoding
        ::TkRoot.new
      end
    end
  end
end

module ::KeypressCapture
  module Graphical
    extend GraphicalHelper
    extend self

    def main
      root.bind :KeyPress, lambda_keypress, '%k %K'
      ::Tk.mainloop
      nil
    end

    private

    def lambda_keypress
      @lambda_keypress ||= ::Kernel.lambda do |key_code, key_sym|
        print "lambda_keypress invoked with keycode #{key_code} and keysym #{key_sym}.\n"
        nil
      end
    end
  end
end

::KeypressCapture::Graphical.main
