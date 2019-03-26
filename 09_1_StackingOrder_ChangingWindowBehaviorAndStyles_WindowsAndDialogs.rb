# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::StackingOrder
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

module ::StackingOrder
  module Graphical
    extend GraphicalHelper
    extend self

    def l_bigger
      @l_bigger_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.text 'Much Bigger Label'
        l.grid column: 0, row: 0, sticky: :w
      end
    end

    def l_little
      @l_little_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.text 'Little'
        l.grid column: 0, row: 0, sticky: :w
      end
    end

    def main
      f_content.padding '3 0 3 0'
      weights_column_and_row_set_up
      l_bigger
      raise_later
      ::Tk.mainloop
      nil
    end

    def proc_raise
      @proc_raise_value ||= ::Kernel.lambda do
        print "proc_raise invoked.\n"
        l_little.raise
        nil
      end
    end

    def raise_later
      milliseconds = 3000
      ::Tk.after milliseconds, proc_raise
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::StackingOrder::Graphical.main
