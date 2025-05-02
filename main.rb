f = File.open("dictionary.txt")

dictionary = []

while line = f.gets do
    dictionary << line
end

puts dictionary.length

dictionary.select! { |word| word.length >= 5 && word.length <= 12}

puts dictionary.length

puts dictionary.sample(1)

f.close