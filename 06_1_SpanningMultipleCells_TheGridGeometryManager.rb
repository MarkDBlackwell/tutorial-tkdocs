# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::SpanningMultipleCells
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

    private

    def tell_tk_which_encoding_to_use
      Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::SpanningMultipleCells
  module GraphicalObjects

    def b_cancel
      @b_cancel_value ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.text 'Cancel'
      end
    end

    def b_okay
      @b_okay_value ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.text 'Okay'
      end
    end

    def ch_one
      @ch_one_value ||= begin
        checked = 1
        c = ::Tk::Tile::CheckButton.new f_content
        c.onvalue checkbutton_value_when_selected
        c.text 'One'
        c.variable ::TkVariable.new checked
      end
    end

    def ch_three
      @ch_three_value ||= begin
        checked = 1
        c = ::Tk::Tile::CheckButton.new f_content
        c.onvalue checkbutton_value_when_selected
        c.text 'Three'
        c.variable ::TkVariable.new checked
      end
    end

    def ch_two
      @ch_two_value ||= begin
        unchecked = 0
        c = ::Tk::Tile::CheckButton.new f_content
        c.onvalue checkbutton_value_when_selected
        c.text 'Two'
        c.variable ::TkVariable.new unchecked
      end
    end

    def e_name
      @e_name_value ||= ::Tk::Tile::Entry.new f_content
    end

    def f_frame_inner
      @f_frame_inner_value ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.borderwidth 5
        f.height 100
        f.relief :sunken
        f.width 200
      end
    end

    def l_label_name
      @l_label_name_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.text 'Name'
      end
    end
  end
end

module ::SpanningMultipleCells
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
# Set up cell behavior:
      column_0_set_up
      column_1_set_up
      column_2_set_up
      column_3_set_up
      column_4_set_up
      ::Tk.mainloop
      nil
    end

    private

    def checkbutton_value_when_selected
      1
    end

    def column_0_set_up
      f_frame_inner.grid column: 0, row: 0, columnspan: 3, rowspan: 2
      ch_one       .grid column: 0, row: 3
      nil
    end

    def column_1_set_up
      ch_two       .grid column: 1, row: 3
      nil
    end

    def column_2_set_up
      ch_three     .grid column: 2, row: 3
      nil
    end

    def column_3_set_up
      l_label_name .grid column: 3, row: 0, columnspan: 2
      e_name       .grid column: 3, row: 1, columnspan: 2
      b_okay       .grid column: 3, row: 3
      nil
    end

    def column_4_set_up
      b_cancel     .grid column: 4, row: 3
      nil
    end
  end
end

::SpanningMultipleCells::Graphical.main
