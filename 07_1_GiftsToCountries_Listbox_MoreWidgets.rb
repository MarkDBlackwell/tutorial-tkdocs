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
      @country_codes_value ||= %i[
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
      @country_names_value ||= %i[
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
      @country_populations_value ||= [
          41000000, 21179211, 10584534,
          185971537, 33148682, 1323128240,
          5457415, 5302000, 64102140,
          11147000, 1131043000, 59206382,
          127718000, 106535000, 16402414,
          4738085, 45116894, 9174082,
          7508700,
          ]
    end
  end
end

module ::GiftsToCountries
  module Gift

    def gifts
      @gifts_value ||= begin
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
      $f_content_value ||= begin
        f = ::Tk::Tile::Frame.new root
        f.grid sticky: :wnes
      end
    end

    def root
      $root_value ||= begin
        tell_tk_which_encoding_to_use
        ::TkRoot.new
      end
    end

    def weights_column_and_row_default_set_up(*args)
      args.reverse.each do |e|
        ::TkGrid.columnconfigure e, 0, weight: 1
        ::TkGrid.   rowconfigure e, 0, weight: 1
      end
      nil
    end

    private

    def tell_tk_which_encoding_to_use
      Tk::Encoding.encoding = ''.encoding
      nil
    end
  end
end

module ::GiftsToCountries
  module Graphical
    extend Country
    extend Gift
    extend GraphicalHelper
    extend self

    def b_send
      @b_send_value ||= begin
        b = ::Tk::Tile::Button.new f_content
        b.command proc_send_gift # Callback.
        b.default :active
        b.text 'Send Gift'
      end
    end

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

      li_countries.bind '<ListboxSelect>', proc_show_population
      li_countries.bind 'Double-1', proc_send_gift

# Backstop every other widget in the tree:
      root.bind 'Return', proc_send_gift
      nil
    end

    def grid_all_the_widgets
      column_0_set_up
      column_1_set_up
      column_2_set_up
    end

    def l_send_label
      @l_send_label_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.text 'Send to country\'s leader:'
      end
    end

    def l_sent_label
      @l_sent_label_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :center
        l.textvariable v_sent
      end
    end

    def l_status_label
      @l_status_label_value ||= begin
        l = ::Tk::Tile::Label.new f_content
        l.anchor :w
        l.textvariable v_status
      end
    end

    def li_countries
      @li_countries_value ||= begin
        l = ::TkListbox.new f_content
        l.height 5
        l.listvariable v_country_names
      end
    end

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
      proc_show_population.call
      ::Tk.mainloop
      nil
    end

    def proc_send_gift
# Called when the user double clicks an item in the listbox, presses the
# 'Send Gift' button, or presses the Return key.
# In case the selected item is scrolled out of view, make sure it is visible.
#
# Figure out which country is selected, and which gift is selected with the
# radiobuttons. Send the gift, and provide feedback that it was sent:

      @proc_send_gift_value ||= ::Kernel.lambda do
        selected = li_countries.curselection
        return unless 1==selected.length
        i = selected.first
        li_countries.see i
# Actually sending the gift is left as an exercise to the reader.
        key = v_gift.value.to_sym
# In order to prevent KeyError exception, supply a default value:
        a = gifts.fetch key, gifts.default
        b = country_names.at i
        v_sent.value = "Sent #{a} to the leader of #{b}."
        nil
      end
    end

    def proc_show_population
# Called when the selection in the listbox changes.
# Figure out which country is currently selected, and look up its country code
# and population. Update the status message with the new population. Clear the
# message about the gift being sent, so it doesn't stick around after we start
# doing other things:

      @proc_show_population_value ||= ::Kernel.lambda do
        selected = li_countries.curselection
        v_sent.value = ''
        return unless 1==selected.length
        i = selected.first
        a = country_names.at i
        b = country_codes.at i
        c = country_populations.at i
        v_status.value = "The population of #{a} (#{b}) is #{c}."
        nil
      end
    end

    def r_gift_0
      @r_gift_0_value ||= begin
        index = 0
        radiobutton_set_up index
      end
    end

    def r_gift_1
      @r_gift_1_value ||= begin
        index = 1
        radiobutton_set_up index
      end
    end

    def r_gift_2
      @r_gift_2_value ||= begin
        index = 2
        radiobutton_set_up index
      end
    end

    def radiobutton_set_up(index)
      key = gifts.keys.at index
      r = ::Tk::Tile::Radiobutton.new f_content
      r.text gifts.fetch key
      r.value key
      r.variable v_gift
    end

# Create and initialize the linked variables we'll need in the interface:

    def v_country_names
      @v_country_names_value ||= ::TkVariable.new country_names
    end

    def v_gift
      @v_gift_value ||= ::TkVariable.new :card
    end

    def v_sent
      @v_sent_value ||= ::TkVariable.new ''
    end

    def v_status
      @v_status_value ||= ::TkVariable.new ''
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
