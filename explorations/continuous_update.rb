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
      f_content.padding '4 4 4 4'
      l_accumulator # Keep before reading the stream.
      v_clock.value = '1'
      lambda_clock_tick.call
      lambda_stream_read.call
      ::Tk.mainloop
      nil
    end

    private

    def clock_tick_schedule_later
      milliseconds = 1000
      ::Tk.after milliseconds, lambda_clock_tick
      nil
    end

    def lambda_clock_tick
      @lambda_clock_tick_value ||= ::Kernel.lambda do
        time_new = 1 + v_clock.value.to_i
        v_clock.value = time_new.to_s
        clock_tick_schedule_later
        nil
      end
    end

    def lambda_stream_read
      @lambda_stream_read_value ||= ::Kernel.lambda do
        stream_read
        read_schedule_later
        nil
      end
    end

    def read_schedule_later
      milliseconds = 100
      ::Tk.after milliseconds, lambda_stream_read
      nil
    end

    def stream_mode
      @stream_mode_value ||= 'rb'
    end

    def stream_read
      raw = stream.getc
      return if raw.nil?

      s = raw.chomp
      v_accumulator.value += s unless s.empty?
      nil
    end
  end
end

::ContinuousUpdate::Graphical.main
