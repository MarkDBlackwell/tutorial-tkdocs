# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

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
      $root_value ||= ::TkRoot.new
    end
  end
end

module ::KeypressCapture
  module Graphical
    extend GraphicalHelper
    extend self

    def events_bind
      root.bind :KeyPress, proc_keypress, '%k %K'
      nil
    end

    def f_frame_inner
      @f_frame_inner_value ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.height 100
        f.width 200
        f.grid
      end
    end

    def main
      f_content.padding '3 3 3 3'
      f_frame_inner
      events_bind
      ::Tk.mainloop
      nil
    end

    def proc_keypress
      @proc_keypress_value ||= ::Kernel.lambda do |key_code, key_sym|
        print "proc_keypress invoked with keycode #{key_code} and keysym #{key_sym}.\n"
        nil
      end
    end
  end
end

::KeypressCapture::Graphical.main
