f = File.open("dictionary.txt")

word_array = []

while line = f.gets do
    word_array << line
end

puts word_array.length

puts word_array.sample(1)

f.close