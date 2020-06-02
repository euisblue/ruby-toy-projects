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
  GRID = [[79,49], [266,46], [431,48], [89, 270], [430, 271], [87, 476], [262, 474], [429, 478]]

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "Tic Tac Toe"
    @color = Gosu::Color::WHITE
    @background = Gosu::Image.new('./board.png')
    @marks = []
    @turn = true
    @xpos = 0
    @ypos = 0
  end

  def update
    if (@xpos >= 79 and @xpos <= 260) and (@ypos >= 49 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[0][0], GRID[0][1]) : XMark.new(GRID[0][0], GRID[0][1])
      @marks.push(m)
      @turn = !@turn
      @xpos = @ypos = 0
    elsif(@xpos >= 266 and @xpos <= 426) and (@ypos >= 46 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[1][0], GRID[1][1]) : XMark.new(GRID[1][0], GRID[1][1])
      @marks.push(m)
      @turn = !@turn
      @xpos = @ypos = 0
    elsif(@xpos >= 431 and @xpos <= 590) and (@ypos >= 48 and @ypos <= 263)
      m = (@turn) ? OMark.new(GRID[2][0], GRID[2][1]) : XMark.new(GRID[2][0], GRID[2][1])
      @marks.push(m)
      @turn = !@turn
      @xpos = @ypos = 0
    end
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      @xpos = mouse_x
      @ypos = mouse_y
      puts "#{@xpos} #{@ypos}"
    end
  end

  def needs_cursor?
    true
  end

  def draw
    @background.draw(0,0,0, 0.8, 1)
    @marks.each { |mark| mark.draw }
  end
end

TicTacToe.new.show
