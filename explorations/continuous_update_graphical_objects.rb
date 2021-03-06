# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::ContinuousUpdate
  module GraphicalObjects

    def l_accumulator
      @l_accumulator_private ||= begin
        pixels = 200
        l = ::Tk::Tile::Label.new f_content
        l.textvariable v_accumulator
        l.wraplength pixels
        l.grid
      end
    end

    def l_clock
      @l_clock_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.textvariable v_clock
        l.grid sticky: 'w'
      end
    end

    def v_accumulator
      @v_accumulator_private ||= ::TkVariable.new ''
    end

    def v_clock
      @v_clock_private ||= ::TkVariable.new ''
    end
  end
end
