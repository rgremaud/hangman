class Game
  def initialize
    @player = Player.new('Romain')
    @game = Logic.new
  end

  def game_loop
    @game.dictionary
    @game.array_build
    @game.letter_input
  end

  # including YAML functions as a baseline - Need to update
  def to_yaml
    YAML.dump({
                word: @word,
                word_array: @word_array
              })
  end

  def self.from_yaml(string)
    data = YAML.load string
    p data
    new(data[:word], data[:word_array])
  end
end
