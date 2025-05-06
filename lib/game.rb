# frozen_string_literal: true

require 'yaml'
require 'random_name_generator'

class Game
  attr_accessor :word, :word_array, :code_array, :score, :wrong_answers

  def initialize
    @word = nil
    @word_array = []
    @code_array = []
    @score = 0
    @wrong_answers = []
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
    alphabet = *('a'..'z')
    puts @code_array.join(' ')
    print 'Please enter a letter.  If you wish to save your game enter SAVE: '
    letter = gets.to_s.chomp
    if letter == 'SAVE'
      save_game
      'Game has been saved!'
      exit
    elsif letter.length >= 2 || alphabet.include?(letter) == false
      puts "Invalid letter."
      letter_input
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
    dir_check = Dir.exist? 'saved_games'
    fls = Dir.entries 'saved_games'
    print 'Would you like to load a saved game?  Please enter yes or no. '
    answer = gets.to_s.chomp
    if answer == 'no'
      dictionary
      array_build
    elsif answer == 'yes' && dir_check == true && fls.length > 2
      dir_files
    elsif answer == 'yes'
      puts "There are no saved games.  Please start a new game."
      game_loop
    else
      puts "Please enter a valid answer"
      return game_loop
    end
    letter_loop
  end

  def to_yaml
    YAML.dump(
      'word' => @word,
      'word_array' => @word_array,
      'code_array' => @code_array,
      'score' => @score,
      'wrong_answers' => @wrong_answers
    )
  end

  def from_yaml(file_name)
    data = YAML.safe_load(File.read("saved_games/#{file_name}.yaml"))
    @word = data['word']
    @word_array = data['word_array']
    @code_array = data['code_array']
    @score = data['score']
    @wrong_answers = data['wrong_answers']
  end

  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'
    rng = RandomNameGenerator.new
    @filename = "#{rng.compose(3)}.yaml"
    File.open("saved_games/#{@filename}", 'w') { |file| file.write to_yaml }
  end

  def dir_files
    puts 'Below is a list of all saved files (if available).'
    puts 'Please enter the name of the file you wish to load: '
    fls = (Dir.entries('saved_games').select { |f| File.file? File.join('saved_games', f) })
    puts fls
    file_name = gets.to_s.chomp
    if fls.include?("#{file_name}.yaml")
      from_yaml(file_name)
      File.delete("saved_games/#{file_name}.yaml")
    else
      dir_files
    end
  end

  

end
