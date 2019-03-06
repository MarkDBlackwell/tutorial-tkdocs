# coding: utf-8
# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::AlertAndConfirmationDialogs
  module About
    extend self

    def details
      @details_value ||= begin
        relevant = group.drop 1
        relevant.map{|e| e.center width}.join "\n"
      end
    end

    def program
      @program_value ||= group.first.center width
    end

    private

    def group
      @group_value ||= raw.lines.map &:chomp
    end

    def raw
      @raw_value ||= <<END
Program-name Program-version
Copyright (c) Year Developer-name
License
Contact: Developer-email
END
    end

    def width
      @width_value ||= group.map(&:length).max
    end
  end
end

module ::AlertAndConfirmationDialogs
  module GraphicalHelper

    def f_content
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_value ||= ::TkRoot.new
    end

    def weights_column_and_row_default_set_up(*args)
      args.reverse.each do |e|
        ::TkGrid.columnconfigure e, 0, weight: 1
        ::TkGrid.   rowconfigure e, 0, weight: 1
      end
      nil
    end
  end
end

module ::AlertAndConfirmationDialogs
  module Graphical
    extend GraphicalHelper
    extend self

    def f_frame_inner
      @f_frame_inner_value ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.height 100
        f.width 200
        f.grid
      end
    end

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      f_frame_inner
      raise_later
      ::Tk.mainloop
      nil
    end

    def proc_about
      @proc_about_value ||= ::Kernel.lambda do
        ::Tk::messageBox message: About.program, detail: About.details
        nil
      end
    end

    def raise_later
      milliseconds = 1000
      ::Tk.after milliseconds, proc_about
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::AlertAndConfirmationDialogs::Graphical.main
