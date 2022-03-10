class Player

  # Cards
  attr_reader :cards_in_draw_deck
  attr_reader :cards_in_hand
  attr_reader :cards_in_play

  # Resources
  attr_reader :solari
  attr_reader :water
  attr_reader :spice

  # Misc.
  attr_reader :leader
  attr_reader :has_swordmaster
  attr_reader :has_high_council
  attr_reader :is_first_player

  FACTIONS = %i[
    emperor
    spacing_guild
    bene_gesserit
    fremen
  ]

  FACTIONS.each do |faction|
    attr_reader :"#{faction}_influence"
    attr_reader :"has_#{faction}_alliance"
  end

  attr_reader :victory_points

  def calculate_victory_points
    (
      faction_level_2_victory_points +
      faction_alliances.length +
      spice_must_flows.length +
      conflict_victory_points +
      intrigue_victory_points
    )
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
