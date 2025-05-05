require_relative 'lib/game'
require_relative 'lib/logic'

require 'yaml'

game = Game.new
#game.dictionary
#game.array_build
#game.save_game

game.from_yaml
p game

# Process for saving a game
# Check if saved game dir exists
# if yes, push YAML file to the dir
# if no, create the saved_game dir
# then push YAML file to dir  
