# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'
require_relative 'continuous_update_shared'
require_relative 'continuous_update_graphical_helper'
require_relative 'continuous_update_graphical_objects'

module ::ContinuousUpdate
  module Graphical
    extend Shared
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      l_accumulator
      proc_stream_read.call
      ::Tk.mainloop
      nil
    end

    private

    def proc_stream_read
      @proc_stream_read_value ||= ::Kernel.lambda do
        stream_read
        read_again_later
        nil
      end
    end

    def read_again_later
      milliseconds = 333
      ::Tk.after milliseconds, proc_stream_read
      nil
    end

    def stream_mode
      @stream_mode_value ||= 'rb'
    end

    def stream_read
      raw = stream.getc
      unless raw.nil?
        s = raw.chomp
        v_accumulator.value += s unless s.empty?
      end
      nil
    end
  end
end

::ContinuousUpdate::Graphical.main
