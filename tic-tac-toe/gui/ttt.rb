require 'gosu'

class XMark
  attr_accessor :xpos, :ypos

  def initialize(x, y)
    @markx = Gosu::Image.new('./markx.png')
    @xpos = x
    @ypos = y
  end

  def draw
    @markx.draw(@xpos,@ypos,0,0.18,0.20)
  end
end

class OMark
  attr_accessor :xpos, :ypos

  def initialize(x, y)
    @markx = Gosu::Image.new('./marko.png')
    @xpos = x
    @ypos = y
  end

  def draw
    @markx.draw(@xpos,@ypos,0,0.14,0.14)
  end
end

class TicTacToe < Gosu::Window
  SCREEN_HEIGHT = 730
  SCREEN_WIDTH = 685
  GRID = [[79,49], [266,46], [431,48], [89, 270], [270, 271], [430, 270], [90, 475], [265, 475], [440, 475]]

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "Tic Tac Toe"
    @board = [ [1,2,3], [4,5,6], [7,8,9] ]    # 3x3 board
    @color = Gosu::Color::WHITE
    @background = Gosu::Image.new('./board.png')
    @marks = []
    @turn = true
    @xpos = 0
    @ypos = 0
    @font = Gosu::Font.new(180, name: "Nimbus Mono L")
    @gameover = false
    @count = 0
  end

  def update
    if (@xpos >= 79 and @xpos <= 260) and (@ypos >= 48 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[0][0], GRID[0][1]) : XMark.new(GRID[0][0], GRID[0][1])
      @marks.push(m)
      @board[0][0] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 266 and @xpos <= 426) and (@ypos >= 48 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[1][0], GRID[1][1]) : XMark.new(GRID[1][0], GRID[1][1])
      @marks.push(m)
      @board[0][1] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 431 and @xpos <= 590) and (@ypos >= 48 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[2][0], GRID[2][1]) : XMark.new(GRID[2][0], GRID[2][1])
      @marks.push(m)
      @board[0][2] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 90 and @xpos <= 257) and (@ypos >= 270 and @ypos <= 460)
      m = (@turn) ? OMark.new(GRID[3][0], GRID[3][1]) : XMark.new(GRID[3][0], GRID[3][1])
      @marks.push(m)
      @board[1][0] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 270 and @xpos <= 420) and (@ypos >= 270 and @ypos <= 460)
      m = (@turn) ? OMark.new(GRID[4][0], GRID[4][1]) : XMark.new(GRID[4][0], GRID[4][1])
      @marks.push(m)
      @board[1][1] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 430 and @xpos <= 595) and (@ypos >= 270 and @ypos <= 460)
      m = (@turn) ? OMark.new(GRID[5][0], GRID[5][1]) : XMark.new(GRID[5][0], GRID[5][1])
      @marks.push(m)
      @board[1][2] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 84 and @xpos <= 253) and (@ypos >= 476 and @ypos <= 686)
      m = (@turn) ? OMark.new(GRID[6][0], GRID[6][1]) : XMark.new(GRID[6][0], GRID[6][1])
      @marks.push(m)
      @board[2][0] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 268 and @xpos <= 475) and (@ypos >= 414 and @ypos <= 683)
      m = (@turn) ? OMark.new(GRID[7][0], GRID[7][1]) : XMark.new(GRID[7][0], GRID[7][1])
      @marks.push(m)
      @board[2][1] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    elsif(@xpos >= 435 and @xpos <= 582) and (@ypos >= 480 and @ypos <= 675)
      m = (@turn) ? OMark.new(GRID[8][0], GRID[8][1]) : XMark.new(GRID[8][0], GRID[8][1])
      @marks.push(m)
      @board[2][2] = (@turn) ? 'o' : 'x';
      @turn = !@turn
      @xpos = @ypos = 0
      @count += 1
    end
  end

  def button_down(id)
    if(!@gameover and @count<9)
      case id
      when Gosu::MsLeft
        @xpos = mouse_x
        @ypos = mouse_y
      end
    end
  end

  def button_up(id)
    if(!@gameover)
      case id
      when Gosu::MsLeft
        check_winner
      end
    end
  end

  def needs_cursor?
    true
  end

  def draw
    @background.draw(0,0,0, 0.8, 1)
    @marks.each { |mark| mark.draw }
    if (@gameover or @count>=9)
      text_input = Gosu::TextInput.new
      text_input.text = @count>=9 ? "Draw !" : @turn ? "X won!" : "O won!"
      @font.draw_text(text_input.text, 100, 240, 0, 1, 1, Gosu::Color.argb(0xff_000000))
    end
  end

  def check_winner
    # horiznotal and vertical check
    0.upto(2) do |i|
      if (@board[i][0] == @board[i][1] and @board[i][1] == @board[i][2]) or
          (@board[0][i] == @board[1][i] and @board[1][i] == @board[2][i]) 
          @gameover = true;
      end
    end

    # diagonal
    if (@board[0][0] == @board[1][1] and @board[1][1] == @board[2][2]) or
        (@board[0][2] == @board[1][1] and @board[1][1] == @board[2][0])
          @gameover = true;
    end
  end
end

TicTacToe.new.show
