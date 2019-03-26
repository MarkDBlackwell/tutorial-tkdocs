# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::ColorPicker
  module Color
    extend self

    attr_accessor :value
  end
end

module ::ColorPicker
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

module ::ColorPicker
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
      Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::ColorPicker
  module GraphicalObjects

    def ca_canvas
      @ca_canvas_value ||= begin
        c = ::TkCanvas.new f_content
        c.grid sticky: :wnes
      end
    end

    def car_color_picker_black
      @car_color_picker_black_value ||= begin
        y_box = 60, 80
        color_picker_create y_box, :black
      end
    end

    def car_color_picker_blue
      @car_color_picker_blue_value ||= begin
        y_box = 35, 55
        color_picker_create y_box, :blue
      end
    end

    def car_color_picker_red
      @car_color_picker_red_value ||= begin
        y_box = 10, 30
        color_picker_create y_box, :red
      end
    end

    private

    def color_picker_create(y_box, color)
      options = { fill: color }
      x_box = 10, 30
      box = x_box.zip(y_box).flatten
      ::TkcRectangle.new ca_canvas, *box, options
    end
  end
end

module ::ColorPicker
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      event_bindings_set_up
      color_initial_set
      ::Tk.mainloop
      nil
    end

    private

    def color_initial_set
      proc_color_set.call :black
      nil
    end

    def event_bindings_set_up
      event_bindings_set_up_canvas
      event_bindings_set_up_color_pickers
      nil
    end

    def event_bindings_set_up_canvas
      ca_canvas.bind '1',         proc_segment_start,  '%x %y'
      ca_canvas.bind 'B1-Motion', proc_segment_append, '%x %y'
      nil
    end

    def event_bindings_set_up_color_pickers
      car_color_picker_black.bind '1', proc_color_set, :black
      car_color_picker_blue. bind '1', proc_color_set, :blue
      car_color_picker_red.  bind '1', proc_color_set, :red
      nil
    end

    def proc_color_set
      @proc_color_set_value ||= ::Kernel.lambda do |v|
        Color.value = v
        nil
      end
    end

    def proc_segment_append
      @proc_segment_append_value ||= ::Kernel.lambda do |x_end, y_end|
        options = { fill: Color.value }
        x_start, y_start = Position.value
        ::TkcLine.new ca_canvas, x_start, y_start, x_end, y_end, options
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

::ColorPicker::Graphical.main
