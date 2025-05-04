require_relative 'lib/game'
require_relative 'lib/logic'

require 'yaml'

new_game = Game.new
# new_game.game_build
new_game.load_game

# p new_game.to_yaml
# new_game = new_game.from_yaml(new_game.to_yaml)
# puts "Word #{new_game.word}"
# puts "Word_array #{new_game.word_array}"
