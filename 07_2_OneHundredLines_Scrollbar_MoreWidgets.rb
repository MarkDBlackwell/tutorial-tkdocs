# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::OneHundredLines
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

    def si_sizegrip
      @si_sizegrip_value ||= begin
        s = ::Tk::Tile::SizeGrip.new root
        s.grid column: 0, row: 0, sticky: :es
      end
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

module ::OneHundredLines
  module Graphical
    extend GraphicalHelper
    extend self

    def l_status_message
      @l_status_message_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :w
        l.text 'Status message here'
        l.grid column: 0, row: 1, sticky: :we
      end
    end

    def li_listbox
      @li_listbox_value ||= begin
        l = ::TkListbox.new f_content
        l.height 5
        l.yscrollcommand proc{|*args| scr_scrollbar.set *args}
        l.grid column: 0, row: 0, sticky: :wnes
      end
    end

    def listbox_lines_insert
      100.times.each do |i|
        li_listbox.insert :end, "Line #{i + 1} of 100"
      end
      nil
    end

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      si_sizegrip
      l_status_message
      listbox_lines_insert
      ::Tk.mainloop
      nil
    end

    def scr_scrollbar
      @scr_scrollbar_value ||= begin
        s = ::Tk::Tile::Scrollbar.new f_content
        s.command proc{|*args| li_listbox.yview *args}
        s.orient :vertical
        s.grid column: 1, row: 0, sticky: :ns
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::OneHundredLines::Graphical.main
