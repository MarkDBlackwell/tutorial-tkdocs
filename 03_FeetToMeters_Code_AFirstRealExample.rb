# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::FeetToMeters
  module GraphicalHelper

    def f_content
# There only can be a single main content frame (for the main window) in the
# program, so use a global:
      $f_content_value ||= begin
# In order to make the entire visible background match that of its
# contained widgets, use a frame:
        f = ::Tk::Tile::Frame.new root
# Pad the overall frame. This supplements padx and pady of each grid box
# (see elsewhere):
        f.padding '3 3 12 12' # Left, Top,   Right, Bottom.
        f.grid sticky: :wnes  # West, North, East,  South.
      end
    end

    def root
# There only can be a single (Tk) root in the program, so use a global:
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

module ::FeetToMeters
  module GraphicalObjects

    def e_feet
      @e_feet_value ||= begin
        e = ::Tk::Tile::Entry.new f_content
        e.textvariable v_feet
        e.width 7
      end
    end

    def v_feet
      @v_feet_value ||= ::TkVariable.new
    end

    def v_meters
      @v_meters_value ||= ::TkVariable.new
    end
  end
end

module ::FeetToMeters
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      weights_column_and_row_set_up
      root.title 'Feet to Meters'
      return_bind
      column_1_set_up
      column_2_set_up
      column_3_set_up
      pad_grid_boxes # Keep below where we fill the grid.
      proc_calculate_and_focus.call
      ::Tk.mainloop
      nil
    end

    private

    def column_1_set_up
      l = ::Tk::Tile::Label.new f_content
      l.text 'is equivalent to'
      l.grid column: 1, row: 2, sticky: :e
      nil
    end

    def column_2_row_1_set_up
      e_feet.grid column: 2, row: 1, sticky: :we
      nil
    end

    def column_2_row_2_set_up
      l = ::Tk::Tile::Label.new f_content
      l.textvariable v_meters
      l.grid column: 2, row: 2, sticky: :we
      nil
    end

    def column_2_set_up
      column_2_row_1_set_up
      column_2_row_2_set_up
      nil
    end

    def column_3_row_1_set_up
      l = ::Tk::Tile::Label.new f_content
      l.text 'feet'
      l.grid column: 3, row: 1, sticky: :w
      nil
    end

    def column_3_row_2_set_up
      l = ::Tk::Tile::Label.new f_content
      l.text 'meters'
      l.grid column: 3, row: 2, sticky: :w
      nil
    end

    def column_3_row_3_set_up
      b = ::Tk::Tile::Button.new f_content
      b.command proc_calculate_and_focus
      b.text 'Calculate'
      b.grid column: 3, row: 3, sticky: :w
      nil
    end

    def column_3_set_up
      column_3_row_1_set_up
      column_3_row_2_set_up
      column_3_row_3_set_up
      nil
    end

    def pad_grid_boxes
      ::TkWinfo.children(f_content).each do |widget|
# Pad each grid box:
        ::TkGrid.configure widget, padx: 5, pady: 5
      end
      nil
    end

    def proc_calculate_and_focus
      @proc_calculate_and_focus_value ||= ::Kernel.lambda do
        e_feet.focus
        decimal_digits = 4
        meters_per_foot = 0.3048
        begin
          v_meters.value = (v_feet * meters_per_foot).round decimal_digits
        rescue ::NoMethodError
          v_meters.value = ''
        end
        nil
      end
    end

    def return_bind
# Backstops every other widget in the tree:
      root.bind 'Return' do
        proc_calculate_and_focus.call
      end
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root

      ::TkGrid.columnconfigure f_content, 4, weight: 1
      ::TkGrid.   rowconfigure f_content, 4, weight: 1
      nil
    end
  end
end

::FeetToMeters::Graphical.main
