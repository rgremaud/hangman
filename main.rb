require_relative 'lib/game'
require_relative 'lib/logic'

require 'msgpack'

game = Game.new
game.dictionary
game.array_build
p game

msg = MessagePack.pack(game)
p msg

# attr_accessor :word, :word_array, :code_array, :score, :wrong_answers
