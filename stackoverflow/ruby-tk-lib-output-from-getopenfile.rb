# See:
#  http://stackoverflow.com/questions/31964822/ruby-tk-lib-output-from-getopenfile

require 'tk'

def extract_filenames(file_list_string)
  except_brace_start = 1..-1
  except_brace_end   = 0..-2
  result = []
  name_containing_spaces = nil # Predefine for block.
  in_name_with_spaces = false
  file_list_string.split(' ').each do |element|
    if in_name_with_spaces
      unless element.end_with? '}'
        name_containing_spaces.push element
      else
        in_name_with_spaces = false
        s_end = element.slice except_brace_end
        name_containing_spaces.push "#{s_end}\""
        result.push name_containing_spaces.join ' '
      end
    else
      unless element.start_with? '{'
        result.push element
      else
        in_name_with_spaces = true
        s_start = element.slice except_brace_start
        name_containing_spaces = ["\"#{s_start}"]
      end
    end
  end
  result.push name_containing_spaces.join ' ' if in_name_with_spaces
  result
end

def files_open
  descriptions = %w[
      Comma\ Separated\ Values
      Text\ Files
      All\ Files
      ]
  extensions = %w[  {.csv}  {.txt}  *  ]
  types = descriptions.zip(extensions).map {|d,e| "{#{d}} #{e}" }
  file_list_string = ::Tk.getOpenFile \
      defaultextension: 'csv',
      filetypes: types,
      multiple: true,
      title: 'Select Files'
  extract_filenames file_list_string
end

def lambda_files_open
  @lambda_files_open ||= ::Kernel.lambda do
    files = files_open
    puts files
  end
end

def main
  b_button_1
  ::Tk.mainloop
end

# Tk objects:

def b_button_1
  @b_button_1 ||= begin
    b = ::TkButton.new root
    b.command lambda_files_open
    b.text 'Open Files'
    b.grid column: 1, row: 1, sticky: :we
  end
end

def root
  @root ||= ::TkRoot.new
end

main
