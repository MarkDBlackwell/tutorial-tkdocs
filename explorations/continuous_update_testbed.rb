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

    def console_filehandle
      @console_filehandle_value ||= begin
        filename = 'con:' # If not on Windows, change this.
        mode = "r:#{encoding_current}:#{encoding_current}"
        ::File.open filename, mode
      end
    end

    def console_read
      console_filehandle.readline.chomp
    end

    def stream_mode
      @stream_mode_value ||= 'w'
    end

    def stream_write(s)
      stream.puts s
# See:
#   http://bugs.ruby-lang.org/issues/9153
#   http://stackoverflow.com/questions/6701103/understanding-ruby-and-os-i-o-buffering

      stream.flush
      nil
    end

    def transfer
      transfer_unicode
      transfer_ascii_from_console
      nil
    end

    def transfer_ascii_from_console
      until 'stop' == (line = console_read)
        stream_write line
      end
      nil
    end

    def transfer_unicode
# Avoid Unicode problems on Windows console keyboard.
# See:
#  http://stackoverflow.com/questions/388490/how-to-use-unicode-characters-in-windows-command-line
#  http://utf8everywhere.org/
#  http://www.honeybadger.io/blog/data-and-end-in-ruby/

      DATA.each_line {|e| stream_write e}
      nil
    end
  end
end

::ContinuousUpdate::Testbed.main

# The following is "Hello" in Greek:
__END__
γεια σας
