require_relative 'lib/game'
require_relative 'lib/logic'

require 'yaml'
require 'random_name_generator'

game = Game.new
game.game_loop
