# coding: utf-8

require 'tk'
require 'tkextlib/tile'

def lambda_clock_tick
  @lambda_clock_tick ||= Kernel.lambda do
    time_new = 1 + v_clock.value.to_i
    v_clock.value = time_new.to_s
# For later, schedule another clock tick:
    milliseconds = 1000
    Tk.after milliseconds, lambda_clock_tick
  end
end

def lambda_stream_read
  @lambda_stream_read ||= Kernel.lambda do
    raw = stream.getc
    unless raw.nil?
      s = raw.chomp
      v_accumulator.value += s unless s.empty?
    end
# Read schedule later:
    milliseconds = 100
    Tk.after milliseconds, lambda_stream_read
  end
end

def main
  l_accumulator # Keep before reading the stream.
  v_clock.value = '1'
  lambda_clock_tick.call
  lambda_stream_read.call
  Tk.mainloop
end

def stream
  @stream ||= begin
    filename = File.expand_path 'continuously_update_stream.txt', __dir__
    File.open filename, 'rb:UTF-8:UTF-8'
  end
end

# Tk objects:

def f_content
  $f_content ||= begin
    f = Tk::Tile::Frame.new root
    f.padding '4 4 4 4' # Left, Top, Right, Bottom.
    f.grid sticky: :wnes
  end
end

def l_accumulator
  @l_accumulator ||= begin
    pixels = 200
    l = Tk::Tile::Label.new f_content
    l.textvariable v_accumulator
    l.wraplength pixels
    l.grid
  end
end

def l_clock
  @l_clock ||= begin
    l = Tk::Tile::Label.new f_content
    l.textvariable v_clock
    l.grid sticky: 'w'
  end
end

def root
  $root ||= begin
# Tell Tk which encoding to use:
    Tk::Encoding.encoding = ''.encoding
    TkRoot.new
  end
end

def v_accumulator
  @v_accumulator ||= TkVariable.new ''
end

def v_clock
  @v_clock ||= TkVariable.new ''
end

main
