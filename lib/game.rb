class Game

  def initialize
  @player = Player.new("Romain")
  @game = Logic.new
  end

  def game_loop
    @game.dictionary
  end

end