class GameBoard
	def initialize()
		@board = Array.new(7) { Array.new(0) }
	end

	<<-DOC
	Adds an X in the Column if there is enough room
	DOC
	def addX(col)
		if @board[col].size < 6
			@board[col].push("X")
		end
	end

	<<-DOC
	Adds an O in the Column
	DOC
	def addO(col)
		if @board[col].size < 6 
			@board[col].push("O")
		end
	end

	<<-DOC
	Returns the Board
	DOC
	def getBoard
		@board
	end

	<<-DOC
	Prints the entire board in connect four format.
	DOC
	def toString
		i = 0
		j = 0
		for i in 0..5
			puts " _ _ _ _ _ _ _"
			print "|"
			for j in 0..6				
				if @board[j][5-i] == "X" || @board[j][5-i] == "O"
					print @board[j][5-i], '|'
				else
					print " |"
				end
			end
			puts ''
		end
		puts " 1 2 3 4 5 6 7 "
	end
end

test = GameBoard.new()
test.addX(1)
test.addO(1)
test.addO(3)
test.toString

