class Game

  attr_reader :players
  attr_reader :rounds

  def current_round
    rounds.last
  end

end
