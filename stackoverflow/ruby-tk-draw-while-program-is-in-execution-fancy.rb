# See:
#  http://stackoverflow.com/questions/27407887/ruby-tk-draw-while-program-is-in-execution

require 'tk'

def board
  @board ||= begin
    size = 3 * 3
    Array.new size, ''
  end
end

def board_initialize
  cv.place height: 350, width: 350, x: 50, y: 100
  ::TkcLine.new cv, 0, 100, 300, 100, width: 5
  ::TkcLine.new cv, 0, 200, 300, 200, width: 5
  ::TkcLine.new cv, 100, 0, 100, 300, width: 5
  ::TkcLine.new cv, 200, 0, 200, 300, width: 5
  nil
end

def board_print
# Use zero-based numbering:
  board.length.times.each do |position|
    marker = board.at position
    offset_x = (position %   3) * 100
    offset_y = (position.div 3) * 100
    if 'X' == marker
      ::TkcLine.new cv, 20 + offset_x, 20 + offset_y, 80 + offset_x, 80 + offset_y, width: 2
      ::TkcLine.new cv, 20 + offset_x, 80 + offset_y, 80 + offset_x, 20 + offset_y, width: 2
    elsif 'O' == marker
    end
  end
  nil
end

def lambda_start_player_computer
  @lambda_start_player_computer ||= ::Kernel.lambda do
    p 'ComputerPlayer, HumanPlayer'
    position = 0
    board[position] = 'X'
    board_print
  end
end

def lambda_start_player_human
  @lambda_start_player_human ||= ::Kernel.lambda do
    p 'HumanPlayer, ComputerPlayer'
  end
end

def main
  board_initialize
  menubar_create
  ::Tk.mainloop
  nil
end

def markers_graphical
  @markers_graphical ||= begin
    Array.new board.length
  end
end

def menubar_create
  root[:menu] = menu
  menu.add :cascade, menu: one, label: 'Select player'
  nil
end

def tear_off_prevent
#   See:
# http://tkdocs.com/tutorial/menus.html
# http://wiki.tcl-lang.org/page/Tearoff

  ::TkOption.add '*tearOff', false
  nil
end

# Tk objects:

def cv
  @cv ||= ::TkCanvas.new root
end

def menu
  @menu ||= begin
    tear_off_prevent # Keep before any menu creation.
    ::TkMenu.new root
  end
end

def one
  @one ||= begin
    m = ::TkMenu.new menu
    m.add :command, label:    'Human first', command: lambda_start_player_human
    m.add :command, label: 'Computer first', command: lambda_start_player_computer
  end
end

def root
  @root ||= begin
    r = ::TkRoot.new
    r.minsize 400, 450
    r.title 'Tic-tac-toe'
  end
end

main
