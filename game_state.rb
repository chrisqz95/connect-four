# A class for a game state of Connect Four.
class GameState
  attr_accessor :board

  @@COLS = 7 # Number of cols on the board
  @@ROWS = 6 # Number of rows on the board
  
  # Initializes a game state with a blank board.
  def initialize
    @board = Array.new(@@COLS) { Array.new }
  end

  # Returns a deep copy of this game state.
  def replicate
    Marshal.load(Marshal.dump(self))
  end

  # Drops 'X' and returns true if the column isn't full.
  # Does nothing and returns false if the column is full.
  def addX(col)
    if @board[col].length < @@ROWS
      @board[col].push("X")
      return true;
    end
    return false;
  end

  # Drops 'O' and returns true if the column isn't full.
  # Does nothing and returns false if the column is full.
  def addO(col)
    if @board[col].length < @@ROWS
      @board[col].push("O")
      return true;
    end
    return false;
  end

  # Evaluates the current game state.
  def evaluate(player)
    return 0
    # TODO
  end

  # Returns num of four-in-a-rows i.e. victory conditions
  def num_four_in_a_row(player)
    # TODO
  end

  # Returns num of three-in-a-rows that aren't four-in-a-rows
  def num_three_in_a_row(player)
    # TODO
  end

  # Returns num of two-in-a-rows that aren't three-in-a-rows or four-in-a-rows
  def num_two_in_a_rows(player)
    # TODO
  end

  # Returns a string representation of the game state.
  def to_s
    str = "==CONNECTFOUR==\n"
    for i in 0...@@ROWS
      str += " - - - - - - - \n"
      str += "|"
      for j in 0...@@COLS
        symbol = (@board[j][@@ROWS - i - 1]) ? @board[j][@@ROWS - i - 1] : " "
        str += format("%s|", symbol)
      end
      str += "\n"
    end
    str += " - - - - - - - \n"
    str += "==============="
  end
end
