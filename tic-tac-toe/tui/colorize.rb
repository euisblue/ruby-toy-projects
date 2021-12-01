class String
  def color_code(code)
    "\e[#{code}m#{self}\e0\e[39m"
  end

  def blue
    color_code(34)
  end

  def red
    color_code(31)
  end
end

def  color(str)
  case str
  when 'O' then str.red
  when 'X' then str.blue
  else str
  end
end
