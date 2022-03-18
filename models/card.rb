class Card

  attr_accessor :player
  attr_accessor :name
  attr_accessor :faction
  attr_accessor :agent_icons
  attr_accessor :agent_box
  attr_accessor :reveal_box
  attr_accessor :pursuasion_cost
  attr_accessor :acquire_effect

  STARTING_DECK_CARD_NAMES = %i[
    convincing_argument
    convincing_argument
    dagger
    dagger
    diplomacy
    dune_the_dessert_planet
    dune_the_dessert_planet
    reconnaissance
    seek_allies
    signet_ring
  ]

  class << self

    def starting_deck
      STARTING_DECK_CARD_NAMES.map do |name|
      end
    end

    def all
      @all ||= YAML.load(File.read('cards.yml')).map do |name, atts|
        new(atts.merge(:name => name))
      end
    end

    def find(name)
      @all_by_name ||= all.each_with_object({}) do |card, hash|
        hash[card.name.to_sym] ||= card
      end
      @all_by_name.fetch(name)
    end

  end

  def initialize(atts = {})
    atts.each do |att, val|
      send("#{att}=", val)
    end
  end

  def play
    resolve_agent_box
  end

private

  def resolve_agent_box
    @agent_box.each do |reward|
      case reward
      when /spice_(?<count>\d+)/
        @player.spice += Integer($~[:count])
      end
    end
  end

end
