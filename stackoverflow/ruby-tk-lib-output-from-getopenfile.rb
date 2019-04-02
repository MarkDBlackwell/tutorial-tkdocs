# See:
#  http://stackoverflow.com/questions/31964822/ruby-tk-lib-output-from-getopenfile

require 'tk'

def extract_filenames_as_ruby_array(file_list_string)
  ::TkVariable.new(file_list_string).list
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
  extract_filenames_as_ruby_array file_list_string
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
