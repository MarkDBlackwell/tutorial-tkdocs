# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

module ::ContinuousUpdate
  module Shared

    def encoding_current
      @encoding_current_value ||= ''.encoding
    end

    def stream
      @stream_value ||= begin
        external = encoding_current
        internal = encoding_current
        mode = "#{stream_mode}:#{external}:#{internal}"
        ::File.open stream_filename, mode
      end
    end

    private

    def stream_filename
      a = %w[  ..  out  continuously-update-stream.txt  ]
      path_relative = ::File.join(*a)
      ::File.expand_path path_relative, __dir__
    end
  end
end
