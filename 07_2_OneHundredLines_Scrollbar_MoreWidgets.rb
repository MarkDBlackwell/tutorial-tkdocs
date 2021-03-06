# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::OneHundredLines
  module GraphicalHelper

    def f_content
      $f_content_private ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_private ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def si_sizegrip
      @si_sizegrip_private ||= begin
        s = ::Tk::Tile::SizeGrip.new root
        s.grid column: 0, row: 0, sticky: :es
      end
    end

    def weights_column_and_row_default_set_up(*args)
      first = 0
      args.reverse_each do |e|
        ::TkGrid.columnconfigure e, first, weight: 1
        ::TkGrid.   rowconfigure e, first, weight: 1
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

module ::OneHundredLines
  module GraphicalObjects

    def l_status_message
      @l_status_message_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :w
        l.text 'Status message here'
        l.grid column: 0, row: 1, sticky: :we
      end
    end

    def li_listbox
      @li_listbox_private ||= begin
        lambda_set = ::Kernel.lambda {|*args| scr_scrollbar.set(*args)}
        l = ::TkListbox.new f_content
        l.height 5
        l.yscrollcommand lambda_set
        l.grid column: 0, row: 0, sticky: :wnes
      end
    end

    def scr_scrollbar
      @scr_scrollbar_private ||= begin
        lambda_view = ::Kernel.lambda {|*args| li_listbox.yview(*args)}
        s = ::Tk::Tile::Scrollbar.new f_content
        s.command lambda_view
        s.orient :vertical
        s.grid column: 1, row: 0, sticky: :ns
      end
    end
  end
end

module ::OneHundredLines
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      si_sizegrip
      l_status_message
      listbox_lines_insert
      ::Tk.mainloop
      nil
    end

    private

    def listbox_lines_insert
      100.times.each do |i|
        li_listbox.insert :end, "Line #{i + 1} of 100"
      end
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::OneHundredLines::Graphical.main
