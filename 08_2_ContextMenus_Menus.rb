# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::ContextMenus
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def me_context_menu
      @me_context_menu_value ||= ::TkMenu.new f_content
    end

    def platform
# Because this lacks Hungarian notation, don't use a global:
      @platform_value ||= ::Tk.windowingsystem
    end

    def root
      $root_value ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def tear_off_prevent
      ::TkOption.add '*tearOff', false
      nil
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

module ::ContextMenus
  module GraphicalObjects

    def f_frame_inner
      @f_frame_inner_value ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.height 100
        f.width 200
        f.grid
      end
    end
  end
end

module ::ContextMenus
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      tear_off_prevent # Keep before any menu creation.
      f_frame_inner
      context_menu_items_add
      context_menu_events_bind
      ::Tk.mainloop
      nil
    end

    private

    def context_menu_events_bind
      events = if 'aqua' == platform # Mac OS X windowing system.
        %w[ 2  Control-1 ]
      else
# App is the symbolic representation of Microsoft Windows' Context Menu key.
        %w[ 3  App  Shift-F10 ]
      end
      events.each do |event|
        root.bind event, proc_popup, '%X %Y'
      end
      nil
    end

    def context_menu_items_add
      items = %w[ One Two Three ]
      items.each do |item|
        me_context_menu.add :command, label: item, command: proc_item
      end
      nil
    end

    def proc_item
      @proc_item_value ||= ::Kernel.lambda do
        print "proc_item invoked.\n"
        nil
      end
    end

    def proc_popup
      @proc_popup_value ||= ::Kernel.lambda do |x,y|
        me_context_menu.popup x, y
        nil
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::ContextMenus::Graphical.main
