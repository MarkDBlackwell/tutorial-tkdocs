# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::Notebook
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

module ::Notebook
  module GraphicalObjects

# For each tab, create a frame, into which widgets can be gridded:

    def f_tab_1
      @f_tab_1_private ||= ::Tk::Tile::Frame.new n_notebook
    end

    def f_tab_2
      @f_tab_2_private ||= ::Tk::Tile::Frame.new n_notebook
    end

    def f_tab_3
      @f_tab_3_private ||= ::Tk::Tile::Frame.new n_notebook
    end

    def l_label_1
      @l_label_1_private ||= begin
        l = ::Tk::Tile::Label.new f_tab_1
        l.text 'Text within tab one.'
        l.grid
      end
    end

    def l_label_2
      @l_label_2_private ||= begin
        l = ::Tk::Tile::Label.new f_tab_2
        l.text 'Text within tab two.'
        l.grid
      end
    end

    def l_label_3
      @l_label_3_private ||= begin
        l = ::Tk::Tile::Label.new f_tab_3
        l.text 'Text within tab three.'
        l.grid
      end
    end

    def n_notebook
      @n_notebook_private ||= begin
        n = ::Tk::Tile::Notebook.new f_content
        n.height 100
        n.width 200
        n.grid sticky: :wnes
      end
    end
  end
end

module ::Notebook
  module Graphical
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '3 3 3 3'
      weights_column_and_row_set_up
      tabs_add
      labels_add
      ::Tk.mainloop
      nil
    end

    private

    def labels_add
      l_label_1
      l_label_2
      l_label_3
      nil
    end

    def tabs_add
      n_notebook.add f_tab_1, text: 'One'
      n_notebook.add f_tab_2, text: 'Two'
      n_notebook.add f_tab_3, text: 'Three'
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up f_content, root
      nil
    end
  end
end

::Notebook::Graphical.main
