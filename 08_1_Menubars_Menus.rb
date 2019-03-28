# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::Menubars
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def me_menubar
# There only can be a single fallback menubar in the program, so use a global:
      $me_menubar_value ||= ::TkMenu.new root
    end

    def root
      $root_value ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def tear_off_prevent
#   See:
# https://tkdocs.com/tutorial/menus.html
# https://wiki.tcl-lang.org/page/Tearoff

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

module ::Menubars
  module GraphicalObjects

    def me_edit
      @me_edit_value ||= ::TkMenu.new me_menubar
    end

    def me_file
      @me_file_value ||= ::TkMenu.new me_menubar
    end

    def v_check
      @ch_check_value ||= ::TkVariable.new
    end

    def v_radio
      @v_radio_value ||= ::TkVariable.new
    end
  end
end

module ::Menubars
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      menu_items_add
      ::Tk.mainloop
      nil
    end

    private

    def menu_edit_items_add
      me_edit.add :command,     label: 'Three',   command: proc_three,      underline: 0
      me_edit.add :command,     label: 'Four',    command: proc_four,       underline: 0
      nil
    end

    def menu_file_items_add
      menu_file_items_file_actions_add
      me_file.add :separator
      menu_file_items_checkbutton_add
      menu_file_items_radiobuttons_add
      nil
    end

    def menu_file_items_checkbutton_add
      me_file.add :checkbutton, label: 'Check',   command: proc_check,      underline: 1, variable: v_check, onvalue: 1, offvalue: 0
      nil
    end

    def menu_file_items_file_actions_add
      me_file.add :command,     label: 'New',     command: proc_file_new,   underline: 0
      me_file.add :command,     label: 'Open...', command: proc_file_open,  underline: 0
      me_file.add :command,     label: 'Close',   command: proc_file_close, underline: 0
      nil
    end

    def menu_file_items_radiobuttons_add
      me_file.add :radiobutton, label: 'One',     command: proc_one,        underline: 2, variable: v_radio, value: 1
      me_file.add :radiobutton, label: 'Two',     command: proc_two,        underline: 0, variable: v_radio, value: 2
      nil
    end

    def menu_items_add
      menubar_create
      menu_edit_items_add
      menu_file_items_add
      nil
    end

    def menubar_create
      tear_off_prevent # Keep before any menu creation.
      root[:menu] = me_menubar
      me_menubar.add :cascade, menu: me_file, label: 'File', underline: 0
      me_menubar.add :cascade, menu: me_edit, label: 'Edit', underline: 0
      nil
    end

    def proc_check
      @proc_check_value ||= ::Kernel.lambda do
        print "proc_check invoked.\n"
        nil
      end
    end

    def proc_file_close
      @proc_file_close_value ||= ::Kernel.lambda do
        print "proc_file_close invoked.\n"
        nil
      end
    end

    def proc_file_new
      @proc_file_new_value ||= ::Kernel.lambda do
        print "proc_file_new invoked.\n"
        nil
      end
    end

    def proc_file_open
      @proc_file_open_value ||= ::Kernel.lambda do
        print "proc_file_open invoked.\n"
        nil
      end
    end

    def proc_four
      @proc_four_value ||= ::Kernel.lambda do
        print "proc_four invoked.\n"
        nil
      end
    end

    def proc_one
      @proc_one_value ||= ::Kernel.lambda do
        print "proc_one invoked.\n"
        nil
      end
    end

    def proc_three
      @proc_three_value ||= ::Kernel.lambda do
        print "proc_three invoked.\n"
        nil
      end
    end

    def proc_two
      @proc_two_value ||= ::Kernel.lambda do
        print "proc_two invoked.\n"
        nil
      end
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::Menubars::Graphical.main
