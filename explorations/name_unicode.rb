# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

# See:
#   http://stackoverflow.com/questions/9112643/is-it-possible-to-use-unicode-characters-with-ruby-tk

require 'tk'
require 'tkextlib/tile'

module ::NameUnicode
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

    private

    def tell_tk_which_encoding_to_use
      ::Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::NameUnicode
  module GraphicalObjects

    def b_submit
      @b_submit_private ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.command lambda_name_print
        b.text 'Submit'
      end
    end

    def e_name
      @e_name_private ||= begin
        e = ::Tk::Tile::Entry.new f_content
        e.textvariable v_name
      end
    end

    def l_reflect
      @l_reflect_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.textvariable v_reflect
      end
    end

    def v_name
      @v_name_private ||= ::TkVariable.new
    end

    def v_reflect
      @v_reflect_private ||= ::TkVariable.new
    end
  end
end

module ::NameUnicode
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      v_name.value = 'γεια σας' # This is "Hello" in Greek.
# Set up cell behavior:
      column_1_set_up
      ::Tk.mainloop
      nil
    end

    private

    def column_1_set_up
      e_name.   grid column: 1, row: 1
      b_submit. grid column: 1, row: 2
      l_reflect.grid column: 1, row: 3
      nil
    end

    def lambda_name_print
      @lambda_name_print_private ||= ::Kernel.lambda do
        value = v_name.value
        v_reflect.value = value
        puts value.encoding
        puts value.inspect
# This works on Windows cmd, but not in ConEmu:
        puts value
        nil
      end
    end
  end
end

::NameUnicode::Graphical.main
