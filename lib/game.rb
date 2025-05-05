# frozen_string_literal: true

require 'yaml'

class Game
  attr_accessor :word, :word_array, :code_array, :score, :wrong_answers

  def initialize
    @word = nil
    @word_array = []
    @code_array = []
    @score = 0
    @wrong_answers = 0
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
    print 'Please enter a letter.  If you wish to save current game enter SAVE: '
    letter = gets.to_s.chomp
    if letter == 'SAVE'
      save_prompt
      'Game has been saved!'
    else
      check(letter)
    end
  end

  def letter_loop
    i = 0
    loop do
      letter_input
      i = @score
      break if i == 7 || @code_array == @word_array
    end
    game_over
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

  def game_loop
    print "Would you like to load a saved game?  Please enter yes or no. "
    answer = gets.to_s.chomp
    if answer == "no"
      dictionary
      array_build
      letter_loop
    else
      puts "Load a game fool"
    end
  end

  def load_game
    load_test
    game_loop
  end

  def to_yaml
    YAML.dump(
                'word' => @word,
                'word_array' => @word_array,
                'code_array' => @code_array,
                'score' => @score,
                'wrong_answers' => @wrong_answers
              )
    #File.open('saved_game.yml', 'w') { |file| file.write(data.to_yaml) }
  end

  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'
    @filename = "saved_game.yaml"
    File.open("saved_games/#{@filename}", 'w') { |file| file.write to_yaml }
  end

  def from_yaml
    data = YAML.safe_load(File.read("saved_games/saved_game.yaml"))
    @word = data['word']
    @word_array = data['word_array']
    @code_array = data['code_array']
    @score = data['score']
    @wrong_answers = data['wrong_answers']
  end

end
