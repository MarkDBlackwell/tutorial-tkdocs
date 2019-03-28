# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::ContinuousUpdate
  module GraphicalObjects

    def l_accumulator
      @l_label_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.textvariable v_accumulator
        l.grid
      end
    end

    def v_accumulator
      @v_accumulator_value ||= ::TkVariable.new ''
    end
  end
end
