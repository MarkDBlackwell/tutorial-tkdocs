# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::AlertAndConfirmationDialogs
  module About
    extend self

    def details
      @details_private ||= begin
        relevant = group.drop 1
        relevant.map {|e| e.center width}.join "\n"
      end
    end

    def program
      @program_private ||= group.first.center width
    end

    private

    def group
      @group_private ||= raw.lines.map(&:strip)
    end

    def raw
      @raw_private ||= <<END_RAW
  Program-name Program-version
  Copyright (c) Year Developer-name
  License
  Contact: Developer-email
END_RAW
    end

    def width
      @width_private ||= group.map(&:length).max
    end
  end
end

module ::AlertAndConfirmationDialogs
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

module ::AlertAndConfirmationDialogs
  module GraphicalObjects

    def f_frame_inner
      @f_frame_inner_private ||= begin
        f = ::Tk::Tile::Frame.new f_content
        f.height 100
        f.width 200
        f.grid
      end
    end
  end
end

module ::AlertAndConfirmationDialogs
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      f_frame_inner
      raise_later
      ::Tk.mainloop
      nil
    end

    private

    def lambda_about
      @lambda_about_private ||= ::Kernel.lambda do
        ::Tk.messageBox message: About.program, detail: About.details
        nil
      end
    end

    def raise_later
      milliseconds = 1000
      ::Tk.after milliseconds, lambda_about
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::AlertAndConfirmationDialogs::Graphical.main
