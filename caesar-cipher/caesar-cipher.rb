def caesar_cipher(str, n)
  for i in 0...str.size do
    c = str[i]
    if c == ' ' then next end
    if !((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z')) then next end
    if c >= 'A' and c <= 'Z' and (c.ord+5) > 90
      str[i] = (64 + (c.ord+n)%90).chr
    elsif c >= 'a' and c <= 'z' and (c.ord+5) > 122 
      str[i] = (96 + (c.ord+n)%122).chr
    else
      str[i] = (str[i].ord+5).chr
    end
  end
  str
end

def caesar_cipher2(str, n)
  return if !str or str.empty?

  for i in 0...str.size do
    c = str[i]
    if (c =~ /[a-z]/)
      c = c.ord + n
      c = (c > 122 ? 96 + (c % 122) : c).chr
    elsif (c =~ /[A-Z]/)
      c = c.ord + n
      c = (c > 90 ? 64 + (c % 90) : c).chr
    end
    str[i] = c
  end

  str
end

def caesar_cipher3(str, n)
  caesar = ""

  str.each_char do |c|
    if c =~ /\W/
      caesar << c
      next
    end

    n.times{ c = c.next }
    caesar << c[-1]
  end

  caesar
end

n = gets.to_i
puts caesar_cipher("What a string!", n)
puts caesar_cipher2("What a string!", n)
puts caesar_cipher3("What a string!", n)
