require './colorize.rb'

class TicTacToe
  def initialize
    system('clear')
    @@row = @@col = 3
    @@p_turn  = '1'  # which player's turn is it
    @@players = {'1': {name: nil, mark: 'O'}, '2': {name: nil, mark: 'X'}}
    @board    = [ ['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'] ]    # 3x3 board
    @playing  = true
    set_players_name
  end

  def set_players_name
    puts "Enter player1's name: "
    @@players[:'1'][:'name'] = gets.chomp
    puts "Enter player2's name: "
    @@players[:'2'][:'name'] = gets.chomp
    system('clear');
  end

  def play
    while true do
      display_board
      turn
      return if !@playing
      system('clear')
    end
  end

  def display_board
    puts "===================================="
    puts "%10s vs. %-10s" % [@@players[:'1'][:name], @@players[:'2'][:name]]
    puts "===================================="
    puts "\t %s | %s | %s" % [color(@board[0][0]), color(@board[0][1]), color(@board[0][2])]
    puts "\t___________"
    puts "\t %s | %s | %s" % [color(@board[1][0]), color(@board[1][1]), color(@board[1][2])]
    puts "\t___________"
    puts "\t %s | %s | %s" % [color(@board[2][0]), color(@board[2][1]), color(@board[2][2])]
    puts
  end

  def turn
    print "#{@@players[@@p_turn.to_sym][:name]}'s turn: " 
    cell = gets.to_i - 1
    while cell < 0 or cell > 8 do
      print "#{@@players[@@p_turn.to_sym][:name]}'s turn: " 
      cell = gets.to_i - 1
    end

    row = cell / @@row
    col = cell % @@col

    while @board[row][col] == 'O' or @board[row][col] == 'X'
      print "#{@@players[@@p_turn.to_sym][:name]}'s turn: " 
      cell = gets.to_i - 1
      row = cell / @@row
      col = cell % @@col
    end

    @board[row][col] = @@players[@@p_turn.to_sym][:mark]

    validate

    @@p_turn = @@p_turn == '1' ? '2' : '1'
  end

  def validate
    # horiznotal and vertical check
    0.upto(2) do |i|
      if (@board[i][0] == @board[i][1] and @board[i][1] == @board[i][2]) or
          (@board[0][i] == @board[1][i] and @board[1][i] == @board[2][i]) 
        system('clear')
        display_board
        puts "%15s" % "#{@@players[@@p_turn.to_sym][:name]} won"
        @playing = false;
      end
    end

    # diagonal
    if (@board[0][0] == @board[1][1] and @board[1][1] == @board[2][2]) or
        (@board[0][2] == @board[1][1] and @board[1][1] == @board[2][0])
      system('clear')
      display_board
      puts "%15s" % "#{@@players[@@p_turn.to_sym][:name]} won"
      @playing = false;
    end
  end
end

t = TicTacToe.new
t.play
