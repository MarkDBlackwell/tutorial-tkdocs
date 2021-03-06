# coding: utf-8

# Copyright (C) 2019 Mark D. Blackwell.

require 'tk'
require 'tkextlib/tile'

module ::GiftsToCountries
  module Country

# Initialize our country database:
#  - the list of country codes (a subset, anyway)
# And, in the same order as the country codes:
#    - a parallel list of country names
#    - a parallel list of country populations

    def country_codes
      @country_codes_private ||= %i[
          ar  au  be
          br  ca  cn
          dk  fi  fr
          gr  in  it
          jp  mx  nl
          no  es  se
          ch
          ]
    end

    def country_names
      @country_names_private ||= %i[
          Argentina  Australia  Belgium
          Brazil  Canada  China
          Denmark  Finland  France
          Greece  India  Italy
          Japan  Mexico  Netherlands
          Norway  Spain  Sweden
          Switzerland
          ]
    end

    def country_populations
      @country_populations_private ||= [
           41_000_000,     21_179_211,     10_584_534,
          185_971_537,     33_148_682,  1_323_128_240,
            5_457_415,      5_302_000,     64_102_140,
           11_147_000,  1_131_043_000,     59_206_382,
          127_718_000,    106_535_000,     16_402_414,
            4_738_085,     45_116_894,      9_174_082,
            7_508_700,
          ]
    end
  end
end

module ::GiftsToCountries
  module Gift

    def gifts
      @gifts_private ||= begin
# Names of the gifts we can send:
        values = %i[ Greeting\ Card  Flowers  Nastygram ]
        keys   = %i[ card            flowers  nastygram ]
        result = keys.zip(values).to_h
        result.default = keys.first
        result
      end
    end
  end
end

module ::GiftsToCountries
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

module ::GiftsToCountries
  module GraphicalObjects

    def b_send
      @b_send_private ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.command lambda_gift_send # Callback.
        b.default :active
        b.text 'Send Gift'
      end
    end

    def l_send_label
      @l_send_label_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.text 'Send to country\'s leader:'
      end
    end

    def l_sent_label
      @l_sent_label_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :center
        l.textvariable v_sent
      end
    end

    def l_status_label
      @l_status_label_private ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :w
        l.textvariable v_status
      end
    end

    def li_countries
      @li_countries_private ||= begin
        l = ::TkListbox.new f_content
        l.height 5
        l.listvariable v_country_names
      end
    end

    def r_gift_0
      @r_gift_0_private ||= begin
        index = 0
        radiobutton_set_up index
      end
    end

    def r_gift_1
      @r_gift_1_private ||= begin
        index = 1
        radiobutton_set_up index
      end
    end

    def r_gift_2
      @r_gift_2_private ||= begin
        index = 2
        radiobutton_set_up index
      end
    end

# Create and initialize the linked variables we'll need in the interface:

    def v_country_names
      @v_country_names_private ||= ::TkVariable.new country_names
    end

    def v_gift
      @v_gift_private ||= ::TkVariable.new :card
    end

    def v_sent
      @v_sent_private ||= ::TkVariable.new ''
    end

    def v_status
      @v_status_private ||= ::TkVariable.new ''
    end

    private

    def radiobutton_set_up(index)
      key = gifts.keys.at index
      r = ::Tk::Tile::Radiobutton.new f_content
      r.text gifts.fetch key
      r.value key
      r.variable v_gift
    end
  end
end

module ::GiftsToCountries
  module Graphical
    extend Country
    extend Gift
    extend GraphicalHelper
    extend GraphicalObjects
    extend self

    def main
      f_content.padding '5 5 12 0'
      weights_column_and_row_set_up
      grid_all_the_widgets
      event_bindings_set_up
      colorize_alternating_lines_of_the_listbox
      first_country_in_the_list = 0
      li_countries.selection_set first_country_in_the_list

# Because the ListboxSelect event normally is generated only when the user
# makes a change, start by explicitly showing the population:
      lambda_country_select.call
      ::Tk.mainloop
      nil
    end

    private

    def colorize_alternating_lines_of_the_listbox
      country_codes.length.times.each_slice(2).map(&:first).each do |i|
        li_countries.itemconfigure i, :background, '#f0f0ff'
      end
      nil
    end

    def column_0_set_up
      li_countries  .grid column: 0, row: 0,    rowspan: 6, sticky: :wnes
      l_status_label.grid column: 0, row: 6, columnspan: 2, sticky: :we
      nil
    end

    def column_1_set_up
      l_send_label  .grid column: 1, row: 0,                            padx: 10, pady: 5
      r_gift_0      .grid column: 1, row: 1,                sticky: :w, padx: 20
      r_gift_1      .grid column: 1, row: 2,                sticky: :w, padx: 20
      r_gift_2      .grid column: 1, row: 3,                sticky: :w, padx: 20
      l_sent_label  .grid column: 1, row: 5, columnspan: 2, sticky: :n, padx:  5, pady: 5
      nil
    end

    def column_2_set_up
      b_send        .grid column: 2, row: 4, sticky: :e
      nil
    end

    def event_bindings_set_up
# Set event bindings for:
# - when the selection in the listbox changes;
# - when the user double clicks the list; and
# - when they hit the Return key.

      li_countries.bind '<ListboxSelect>', lambda_country_select
      li_countries.bind 'Double-1', lambda_gift_send

# Backstop every other widget in the tree:
      root.bind 'Return', lambda_gift_send
      nil
    end

    def feedback_provide(index)
      key = v_gift.value.to_sym
# In order to prevent KeyError exception, supply a default value:
      a = gifts.fetch key, gifts.default
      b = country_names.at index
      v_sent.value = "Sent #{a} to the leader of #{b}."
      nil
    end

    def grid_all_the_widgets
      column_0_set_up
      column_1_set_up
      column_2_set_up
    end

    def lambda_country_select
# Called when the selection in the listbox changes.
# Figure out which country is currently selected, and look up its country code
# and population. Update the status message with the new population. Clear the
# message about the gift being sent, so it doesn't stick around after we start
# doing other things:

      @lambda_country_select_private ||= ::Kernel.lambda do
        selected = li_countries.curselection
        v_sent.value = ''
        return unless 1 == selected.length

        population_show selected.first
        nil
      end
    end

    def lambda_gift_send
# Called when the user double clicks an item in the listbox, presses the
# 'Send Gift' button, or presses the Return key.
# In case the selected item is scrolled out of view, make sure it is visible.
#
# Figure out which country is selected, and which gift is selected with the
# radiobuttons. Send the gift, and provide feedback that it was sent:

      @lambda_gift_send_private ||= ::Kernel.lambda do
        selected = li_countries.curselection
        return unless 1 == selected.length

        i = selected.first
        li_countries.see i
# Actually sending the gift is left as an exercise to the reader.
        feedback_provide i
        nil
      end
    end

    def population_show(index)
      i = index
      a = country_names.at i
      b = country_codes.at i
      c = country_populations.at i
      v_status.value = "The population of #{a} (#{b}) is #{c}."
      nil
    end

    def weights_column_and_row_set_up
      weights_column_and_row_default_set_up root

      ::TkGrid.columnconfigure f_content, 0, weight: 1
      ::TkGrid.   rowconfigure f_content, 5, weight: 1
      nil
    end
  end
end

::GiftsToCountries::Graphical.main
