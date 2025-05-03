# frozen_string_literal: true

require 'yaml'

class Game
  def initialize
    @game = Logic.new
  end

  def game_build
    @game.dictionary
    @game.array_build
    @game.game_loop
  end
end
