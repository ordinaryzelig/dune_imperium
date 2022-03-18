class Player

  # Cards
  attr_accessor :cards_in_draw_deck
  attr_accessor :cards_in_hand
  attr_accessor :cards_in_play

  RESOURCE_FIELDS = %i[
    solari
    water
    spice
  ].each do |resource|
    attr_accessor resource
  end

  # Misc.
  attr_accessor :leader
  attr_accessor :has_swordmaster
  attr_accessor :has_high_council
  attr_accessor :is_first_player

  FACTIONS = %i[
    emperor
    spacing_guild
    bene_gesserit
    fremen
  ]

  FACTIONS.each do |faction|
    attr_accessor :"#{faction}_influence"
    attr_accessor :"has_#{faction}_alliance"
  end

  attr_accessor :victory_points

  def initialize
    @cards_in_draw_deck = []
    @cards_in_hand      = []
    @cards_in_play      = []
    RESOURCE_FIELDS.each do |field|
      send("#{field}=", 0)
    end
  end

  def calculate_victory_points
    (
      faction_level_2_victory_points +
      faction_alliances.length +
      spice_must_flows.length +
      conflict_victory_points +
      intrigue_victory_points
    )
  end

  def add_card(card)
    card.player = self
    @cards_in_draw_deck << card
  end

  def draw_hand
    @cards_in_hand.push *@cards_in_draw_deck.first(5)
  end

private

  def faction_level_2_victory_points
    FACTIONS.select do |faction|
      faction_influence(faction) >= 2
    end.length
  end

  def faction_influence(faction)
    send("#{faction}_influence")
  end

end
