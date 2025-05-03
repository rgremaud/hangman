# frozen_string_literal: true

require 'yaml'

class Logic
  attr_accessor :word, :word_array

  def initialize
    @word = nil
    @word_array = []
    @code_array = []
    @score = 0
    @wrong_answers = []
  end

  def to_yaml
    YAML.dump({
                word: @word,
                word_array: @word_array,
                code_array: @code_array,
                score: @score,
                wrong_answers: @wrong_answers
              })
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
  end

  def array_build
    @word_array = @word.split('')
    @word_array.each do
      @code_array << '_'
    end
  end

  def check(letter)
    if @word_array.include?(letter)
      index_array = @word_array.each_index.select { |index| @word_array[index] == letter }
      index_array.each do |number|
        @code_array[number] = letter
      end
    else
      @score += 1
      @wrong_answers << letter
      puts "I'm sorry, #{letter} is not included in the word"
      puts "Current number of wrong guesses is #{@score}.  Once you reach 7 that is game over!"
      puts 'Wrong guesses thus far: '
      puts @wrong_answers.join(' ')
    end
  end

  def letter_input
    puts @code_array.join(' ')
    print 'Please enter a letter: '
    letter = gets.to_s.chomp
    check(letter)
  end

  def game_loop
    i = 0
    loop do
      save_prompt
      letter_input
      i = @score
      break if i == 7 || @code_array == @word_array
    end
    game_over
  end

  def save_prompt
    print 'Would you like to save? Enter Y or N '
    answer = gets.to_s.chomp
    return unless answer == 'Y'

    save = to_yaml
    File.open('saved_game.yml', 'w') { |file| file.write(save.to_yaml) }
  end

  def game_over
    if @code_array == @word_array
      puts @code_array.join(' ')
      puts 'Congratulations!  You win!'
    else
      puts 'Better luck next time!  The word was: '
      puts @word_array.join('')
    end
  end
end
