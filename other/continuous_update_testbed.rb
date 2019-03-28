# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require_relative 'continuous_update_shared'

module ::ContinuousUpdate
  module Testbed
    extend Shared
    extend self

    def main
      stream # Initialize output file.
      transfer
      nil
    end

    private

    def avoid_unicode_problem_with_windows_console_keyboard
# See:
#  http://stackoverflow.com/questions/388490/how-to-use-unicode-characters-in-windows-command-line
#  http://utf8everywhere.org/
#  http://www.honeybadger.io/blog/data-and-end-in-ruby/
      DATA.each_line do |line|
        stream_write line
      end
      nil
    end

    def console_read
      filehandle.readline.chomp
    end

    def filehandle
      @filehandle_value ||= begin
        filename = 'con:' # If not on Windows, change this.
        mode = "r:#{encoding_current}:#{encoding_current}"
        ::File.open filename, mode
      end
    end

    def stream_mode
      @stream_mode_value ||= 'w'
    end

    def stream_write(s)
      stream.puts s
# See:
#   http://stackoverflow.com/questions/6701103/understanding-ruby-and-os-i-o-buffering

      stream.flush
      nil
    end

    def transfer
      transfer_unicode
      transfer_from_console
      nil
    end

    def transfer_from_console
      s = console_read
      until 'stop' == s
        stream_write s
        s = console_read
      end
      nil
    end

    def transfer_unicode
      avoid_unicode_problem_with_windows_console_keyboard
      nil
    end
  end
end

::ContinuousUpdate::Testbed.main
# The following is "Hello" in Russian.
__END__
Привет
