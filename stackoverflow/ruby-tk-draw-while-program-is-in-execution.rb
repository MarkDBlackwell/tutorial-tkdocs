require 'tk' # Added this line.

def initialize_board
  @root = TkRoot.new { minsize(400, 450) }
  @root.title = "Tic-tac-toe"

  @cv = TkCanvas.new @root
  @cv.place('height' => 350, 'width' => 350, 'x' => 50, 'y' => 100)
  TkcLine.new @cv, 0, 100, 300, 100, width: 5
  TkcLine.new @cv, 0, 200, 300, 200, width: 5
  TkcLine.new @cv, 100, 0, 100, 300, width: 5
  TkcLine.new @cv, 200, 0, 200, 300, width: 5

  @menu = TkMenu.new
  one = TkMenu.new @menu
  @menu.add('cascade', :menu => one, :label => 'Select player')
  one.add('command', :label => 'Human first', :command => proc { set_players_and_play(HumanPlayer, ComputerPlayer) })
  one.add('command', :label => 'Computer first', :command => proc { set_players_and_play(ComputerPlayer, HumanPlayer) })

  @root.menu @menu

  Tk.mainloop
end

def print_board
  (1..9).each do |i|
    position, marker = i, @board[i]
    if marker.eql? "X"
      case position
      when 1
        TkcLine.new @cv, 20, 20, 80, 80, width: 2
        TkcLine.new @cv, 20, 80, 80, 20, width: 2
        #Tk.mainloop
      end
    elsif marker == "O"
    end
  end
end

# Added these lines, below:

HumanPlayer = 'Human player'
ComputerPlayer = 'Computer player'

size = 3 * 3
@board = Array.new size + 1, ''

def set_players_and_play(player_first, player_second)
  puts "#{player_first} first, then #{player_second}"
  if ComputerPlayer == player_first
    @board[1] = 'X'
    print_board
  end
end

initialize_board
print_board
