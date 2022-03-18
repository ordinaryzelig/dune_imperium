require 'test_helper'

describe Player do

  it 'players a card and earns agent box reward' do
    player = Player.new
    worm_rider = Card.find(:worm_rider)
    player.add_card(worm_rider)
    player.draw_hand

    player.cards_in_hand.first.play

    player.spice.must_equal 2
  end

end
