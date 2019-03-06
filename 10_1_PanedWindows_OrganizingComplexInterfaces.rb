# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::PanedWindows
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_value ||= ::TkRoot.new
    end

    def weights_column_and_row_default_set_up(*args)
      args.reverse.each do |e|
        ::TkGrid.columnconfigure e, 0, weight: 1
        ::TkGrid.   rowconfigure e, 0, weight: 1
      end
      nil
    end
  end
end

module ::PanedWindows
  module Graphical
    extend GraphicalHelper
    extend self

    def add_frames_to_paned_windows
      pa_horizontal.add la_horizontal_1
      pa_horizontal.add la_horizontal_2
      pa_vertical.  add la_vertical_3
      pa_vertical.  add la_vertical_4
      nil
    end

# Create labelframes, into which widgets can be gridded:

    def la_horizontal_1
      @la_horizontal_1_value ||= begin
        l = labelframe_set_up pa_horizontal
        l.text 'Pane1'
        l.width 100
      end
    end

    def la_horizontal_2
      @la_horizontal_2_value ||= begin
        l = labelframe_set_up pa_horizontal
        l.text 'Pane2'
        l.width 100
      end
    end

    def la_vertical_3
      @la_vertical_3_value ||= begin
        l = labelframe_set_up pa_vertical
        l.text 'Pane3'
      end
    end

    def la_vertical_4
      @la_vertical_4_value ||= begin
        l = labelframe_set_up pa_vertical
        l.text 'Pane4'
      end
    end

    def labelframe_set_up(orientation)
      l = ::Tk::Tile::Labelframe.new orientation
      l.height 100
    end

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      add_frames_to_paned_windows
      ::Tk.mainloop
      nil
    end

    def pa_horizontal
      @pa_horizontal_value ||= begin
        p = ::Tk::Tile::Paned.new f_content, orient: :horizontal
        p.grid column: 0, row: 0, sticky: :wnes
      end
    end

    def pa_vertical
      @pa_vertical_value ||= begin
        p = ::Tk::Tile::Paned.new f_content, orient: :vertical
        p.grid column: 0, row: 1, sticky: :wnes
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      ::TkGrid.rowconfigure f_content, 1, weight: 1
      nil
    end
  end
end

::PanedWindows::Graphical.main
