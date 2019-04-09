# coding: utf-8

# See:
#  http://stackoverflow.com/questions/55602789/how-can-i-determine-most-easily-the-keysyms-of-unusual-keys-on-my-keyboard-in-r

require 'tk'
require 'tkextlib/tile'

module ::KeypressCapture
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def platform
      @platform_value ||= ::Tk.windowingsystem
    end

    def root
      $root_value ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    private

    def tell_tk_which_encoding_to_use
      ::Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::KeypressCapture
  module GraphicalObjects

    def f_frame_inner
      @f_frame_inner_value ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.height 100
        f.width 200
        f.grid
      end
    end
  end
end

module ::KeypressCapture
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      f_frame_inner
      events_bind
      ::Tk.mainloop
      nil
    end

    private

    def events_bind
      root.bind :KeyPress, lambda_keypress, '%k %K'
      nil
    end

    def lambda_keypress
      @lambda_keypress_value ||= ::Kernel.lambda do |key_code, key_sym|
        print "lambda_keypress invoked with keycode #{key_code} and keysym #{key_sym}.\n"
        nil
      end
    end
  end
end

::KeypressCapture::Graphical.main
