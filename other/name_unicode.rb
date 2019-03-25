# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

# See:
#   https://stackoverflow.com/questions/9112643/is-it-possible-to-use-unicode-characters-with-ruby-tk

require 'tk'
require 'tkextlib/tile'

module ::NameUnicode
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

    def tell_tk_which_encoding_to_use
      Tk::Encoding.encoding = ''.encoding
        nil
    end
  end
end

module ::NameUnicode
  module Graphical
    extend GraphicalHelper
    extend self

    def b_submit
      @b_submit_value ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.command proc_name_print
        b.text 'Submit'
      end
    end

    def column_1_set_up
      e_name.grid column: 1, row: 1
      nil
    end

    def column_2_set_up
      b_submit.grid column: 2, row: 1
      nil
    end

    def e_name
      @e_name_value ||= begin
        e = ::Tk::Tile::Entry.new f_content
        e.textvariable v_name
      end
    end

    def main
      tell_tk_which_encoding_to_use
      v_name.value = 'привет'
# Set up cell behavior:
      column_1_set_up
      column_2_set_up
      ::Tk.mainloop
      nil
    end

    def proc_name_print
      @proc_name_print_value ||= ::Kernel.lambda do
        value = v_name.value
        puts value.encoding
        puts value.inspect
# This works on Windows cmd, but not in ConEmu:
        puts value
        nil
      end
    end

    def v_name
      @v_name_value ||= ::TkVariable.new
    end
  end
end

::NameUnicode::Graphical.main
