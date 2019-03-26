# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::UnknownOption
  class Graphical

    def main
      root = ::TkRoot.new
      $f_content = ::Tk::Tile::Frame.new root do
      end.grid

      good
      bad
      ::Tk.mainloop
    end

    private

    def bad
      a = v_bad
      e_bad = ::Tk::Tile::Entry.new $f_content do
# Use of method fails, here:
        textvariable a
      end
      e_bad.grid
    end

    def good
      v_good = ::TkVariable.new

      e_good = ::Tk::Tile::Entry.new $f_content do
        textvariable v_good
      end
      e_good.grid
    end

    def v_bad
      @v_bad_value ||= ::TkVariable.new
    end
  end
end

::UnknownOption::Graphical.new.main
