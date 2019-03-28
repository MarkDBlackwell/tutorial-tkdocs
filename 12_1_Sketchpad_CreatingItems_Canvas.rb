# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::Sketchpad
  module Position
    extend self

    def set(x, y)
      @x, @y = x, y
      nil
    end

    def value
      [@x, @y]
    end
  end
end

module ::Sketchpad
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_value ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def weights_column_and_row_default_set_up(*args)
      args.reverse_each do |e|
        ::TkGrid.columnconfigure e, 0, weight: 1
        ::TkGrid.   rowconfigure e, 0, weight: 1
      end
      nil
    end

    private

    def tell_tk_which_encoding_to_use
      ::Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::Sketchpad
  module GraphicalObjects

    def ca_canvas
      @ca_canvas_value ||= begin
        c = ::TkCanvas.new f_content
        c.grid sticky: :wnes
      end
    end
  end
end

module ::Sketchpad
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      event_bindings_set_up
      ::Tk.mainloop
      nil
    end

    private

    def event_bindings_set_up
      event_bindings_set_up_canvas
      nil
    end

    def event_bindings_set_up_canvas
      ca_canvas.bind '1',         proc_segment_start,  '%x %y'
      ca_canvas.bind 'B1-Motion', proc_segment_append, '%x %y'
      nil
    end

    def proc_segment_append
      @proc_segment_append_value ||= ::Kernel.lambda do |x_end, y_end|
        x_start, y_start = Position.value
        ::TkcLine.new ca_canvas, x_start, y_start, x_end, y_end
        Position.set x_end, y_end
        nil
      end
    end

    def proc_segment_start
      @proc_segment_start_value ||= ::Kernel.lambda do |x,y|
        Position.set x, y
        nil
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::Sketchpad::Graphical.main
