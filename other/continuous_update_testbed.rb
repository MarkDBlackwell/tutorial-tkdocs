# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require_relative 'continuous_update_shared'

module ::ContinuousUpdate
  module Testbed
    extend Shared
    extend self

    def main
      stream # Initialize output file.
      filename = 'con:' # If not on Windows, change this.
      mode = "r:#{encoding_current}:#{encoding_current}"
      ::File.open filename, mode do |f|
        transfer f
      end
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

    def console_read(f)
      f.readline.chomp
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

    def transfer(f)
      avoid_unicode_problem_with_windows_console_keyboard
      s = console_read f
      until 'stop' == s
        stream_write s
        s = console_read f
      end
      nil
    end
  end
end

::ContinuousUpdate::Testbed.main
# The following is "Hello" in Russian.
__END__
Привет
