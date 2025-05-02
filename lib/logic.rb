require 'yaml'

class Logic
  attr_accessor :word, :word_array
  def initialize
    @word = nil
    @word_array = []
  end

  def to_yaml
    YAML.dump ({
      :word => @word,
      :word_array => @word_array
    })
  end

  def self.from_yaml(string)
    data = YAML.load string
    p data 
    self.new(data[:word],data[:word_array])
  end

  def dictionary
    f = File.open("lib/dictionary.txt")
    dictionary = []
    while line = f.gets do
      dictionary << line
    end
    dictionary.select! { |word| word.length >= 5 && word.length <= 12}
    @word = dictionary.sample
    @word = @word.chomp
    p @word.length
    puts "The word is #{@word}"
  end
  
 
end