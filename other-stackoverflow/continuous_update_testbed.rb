# coding: utf-8

def console_filehandle
  @console_filehandle ||= begin
    filename = 'con:' # If not on Windows, change this.
    File.open filename, 'r:UTF-8:UTF-8'
  end
end

def console_read
  console_filehandle.readline.chomp
end

def main
  stream # Initialize output file.
  transfer_unicode
  transfer_ascii_from_console
end

def stream
  @stream ||= begin
    filename = File.expand_path 'continuously_update_stream.txt', __dir__
    File.open filename, 'w:UTF-8:UTF-8'
  end
end

def stream_write(s)
  stream.puts s
# See:
#   http://bugs.ruby-lang.org/issues/9153
#   http://stackoverflow.com/questions/6701103/understanding-ruby-and-os-i-o-buffering

  stream.flush
end

def transfer_ascii_from_console
  line = console_read
  until 'stop' == line
    stream_write line
    line = console_read
  end
end

def transfer_unicode
# Avoid Unicode problems on Windows console keyboard.
# See:
#  http://stackoverflow.com/questions/388490/how-to-use-unicode-characters-in-windows-command-line
#  http://utf8everywhere.org/
#  http://www.honeybadger.io/blog/data-and-end-in-ruby/

  DATA.each_line {|e| stream_write e}
end

main

# The following is "Hello" in Greek:
__END__
γεια σας
