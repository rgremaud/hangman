# frozen_string_literal: true

require 'yaml'

class Logic
  attr_accessor :word, :word_array

  def initialize
    @word = nil
    @word_array = []
    @code_array = []
  end

  def dictionary
    f = File.open('lib/dictionary.txt')
    dictionary = []
    while line = f.gets
      dictionary << line
    end
    dictionary.select! { |word| word.length >= 6 && word.length <= 13 }
    @word = dictionary.sample
    @word = @word.chomp
    p @word.length
    puts "The word is #{@word}"
  end

  def array_build
    @word_array = @word.split('')
    p @word_array
    p @word_array[0]
    @word_array.each do |letter|
      @code_array << '_'
    end
    p @code_array
  end

  def check(letter)
    if @word_array.include?(letter)
      # need to update for multiple occurances
      # Example: @word_array.each_index.select { |letter| @word_array[letter] == letter }
      puts 'Included'
      letter_index = @word_array.find_index(letter)
      @code_array[letter_index] = letter
      p @code_array
    else
      puts 'Not included'
    end
  end

  def letter_input
    print 'Please enter a letter: '
    letter = gets.to_s.chomp
    puts letter
    check(letter)
  end
end
