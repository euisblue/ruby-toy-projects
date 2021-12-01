def caesar_cipher(str, n)
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

print "Enter a message: "
message = gets.chomp
print "Shift how many times? "
n = gets.to_i

puts "Original Message: '#{message}'"
puts "Caesar Ciphered : '#{caesar_cipher(message, n)}'"

