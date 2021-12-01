class Player 
  attr_accessor :mark, :msg

  def initialize(mark)
    @mark = mark
    @msg = " turn for [#{mark}]: "
  end
end 

class Board  
  attr_accessor :board 

  def initialize(x, y)
    @board = Array.new(x) { Array.new(y) } 
    @width = x
    @height = y
    for i in 0...@height do 
      for j in 0...@width do 
        @board[i][j] = (i*y) + (j+1)
      end
    end 
  end

  def display
    for i in 0...@height do 
      puts " -------------"
      for j in 0...@width do 
        print " | #{@board[i][j]}"
      end
      puts " |"
    end 
    puts " -------------"
  end
end 

class TicTacToe
  def initialize 
    @board = Board.new(3, 3)
    @p1 = Player.new('O')
    @p2 = Player.new('X')
  end 

  def play 
    board = @board.board
    turn = @p1

    system('clear')
    @board.display
    10.times do |cnt|
      # draw
      if cnt == 9
        turn = nil 
        break
      end

      print turn.msg
      pos = gets.to_i

      # error checking
      while pos < 1 or pos > 9
        print "#{turn.msg} (enter between 1~9): "
        pos = gets.to_i
      end

      # error checking - can you mark there?
      y, x = [(pos-1)/3, (pos-1)%3]
      while board[y][x] == 'O' or board[y][x] == 'X'
        print "#{turn.msg} (choose a spot with the number): "
        pos = gets.to_i
        y, x = [(pos-1)/3, (pos-1)%3]
      end
      board[y][x] = turn.mark
      system('clear')
      @board.display
      
      # check if anybody won
      break if check_winner == true

      # toggle player
      turn = (turn == @p1) ? @p2 : @p1
    end

    puts (turn == nil) ? " Draw!" : " [#{turn.mark}] won!"
  end 

  def check_winner 
    board = @board.board
    # horizontal check
    if (board[0][0] == board[0][1] and board[0][1] == board[0][2]) or
        (board[1][0] == board[1][1] and board[1][1] == board[1][2]) or 
        (board[2][0] == board[2][1] and board[2][1] == board[2][2]) 
      return true
    end
    # vertical check
    if (board[0][0] == board[1][0] and board[1][0] == board[2][0]) or
        (board[0][1] == board[1][1] and board[1][1] == board[2][1]) or 
        (board[0][2] == board[1][2] and board[1][2] == board[2][2]) 
      return true
    end
    # diagonal check
    if (board[0][0] == board[1][1] and board[1][1] == board[2][2]) or
        (board[0][2] == board[1][1] and board[1][1] == board[2][0]) 
      return true
    end

    return false
  end
end

ttt = TicTacToe.new
ttt.play
