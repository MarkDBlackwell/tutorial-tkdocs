# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::LoggingWindow
  module GraphicalHelper

    def f_content
      $f_content_private ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_private ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def weights_column_and_row_default_set_up(*args)
      first = 0
      args.reverse_each do |e|
        ::TkGrid.columnconfigure e, first, weight: 1
        ::TkGrid.   rowconfigure e, first, weight: 1
      end
      nil
    end

    private

    def tell_tk_which_encoding_to_use
      ::Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::LoggingWindow
  module GraphicalObjects

    def t_log
      @t_log_private ||= begin
        t = ::TkText.new f_content
        t.height 24
        t.state :disabled
        t.width 80
        t.wrap :none
        t.grid
      end
    end
  end
end

module ::LoggingWindow
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      weights_column_and_row_set_up
      lines_write
      ::Tk.mainloop
      nil
    end

    private

    def lines_write
      size = 25
      size.times.each do |i|
        log_write "Line #{i + 1} of #{size}"
      end
      nil
    end

    def log_delete_some_maybe
      t_log.delete 1.0, 2.0 unless log_line_count < 24
      nil
    end

    def log_line_count
      t_log.index('end - 1 line').split('.').first.to_i
    end

    def log_newline_append_maybe
      t_log.insert :end, "\n" unless '1.0' == (t_log.index 'end-1c')
      nil
    end

    def log_write(message)
      t_log[:state] = :normal
      log_delete_some_maybe
      log_newline_append_maybe
      t_log.insert :end, message
      t_log[:state] = :disabled
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::LoggingWindow::Graphical.main
