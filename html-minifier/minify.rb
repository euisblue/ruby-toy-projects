print "Enter the file name: "
filename = gets.chomp
file = File.open(filename, 'r')
str = ''

while file.eof? != true 
  temp  = file.gets
  while temp.include? "<!--"
    temp = temp.slice(0, temp.index("<!--"))
  end 
  str += temp.strip.chomp
end 

file.close

new_filename = "minified_" + filename 
puts ".. generating [#{new_filename}]"

File.open(new_filename, "w") { |newfile| newfile.write str }

puts ".. DONE"
