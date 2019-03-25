# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::EventBindings
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
      args.reverse.each do |e|
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

module ::EventBindings
  module Graphical
    extend GraphicalHelper
    extend self

    def l_label
      @l_label_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.grid
      end
    end

    def label_bind
      l_label.bind '1' do
        l_label[:text] = 'Clicked left mouse button'
      end

      l_label.bind 'B3-Motion', proc_drag, '%x %y'

      l_label.bind 'Double-1' do
        l_label[:text] = 'Double clicked'
      end

      l_label.bind 'Enter' do
        l_label[:text] = 'Moved mouse inside'
      end

      l_label.bind 'Leave' do
        l_label[:text] = 'Moved mouse outside'
      end
      nil
    end

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      l_label[:text] = 'Starting...'
      label_bind
      ::Tk.mainloop
      nil
    end

    def proc_drag
      @proc_drag_value ||= ::Kernel.lambda do |x,y|
        l_label[:text] = "Right button drag to #{x}, #{y}"
        nil
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::EventBindings::Graphical.main
