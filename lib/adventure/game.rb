# frozen_string_literal: true

require_relative 'room'

module Adventure
  # Gem's name.
  class Game
    # The adventure's title / name.
    attr_reader :title
    # The adventure's subtitle / flavor text.
    attr_reader :subtitle
    # An Array of authors, in the format `Name <email> (url)`.
    attr_reader :authors
    # The full name of the license this adventure is released under.
    attr_reader :license
    # The year (or years) of development of this adventure.
    attr_reader :year
    # A longer description of this adventure.
    attr_reader :description
    # Number of players for which this adventure is developed.
    attr_reader :players
    # The initial level for the player(s).
    attr_reader :starting_level
    # Initially the **starting** room for this adventure, then, during the adventure execution, the algorithm will use as the actual current room for the party.
    attr_reader :current_room
    # A Hash of variables to be used by the adventure --- currently unused, kept as placeholder.
    attr_reader :global_vars

    # TODO: Write documentation.
    def initialize(**opts)
      @title          = opts.key?(:title) ? opts[:title].trim : ''
      @subtitle       = opts.key?(:subtitle) ? opts[:subtitle].trim : ''
      @authors        = opts.key?(:authors) ? opts[:authors].to_a : []
      @license        = opts.key?(:license) ? opts[:license].trim : ''
      @year           = opts.key?(:year) ? opts[:year].trim : ''
      @description    = opts.key?(:description) ? opts[:description].trim : ''
      @players        = opts.key?(:players) ? opts[:players].to_i : 1
      @starting_level = opts.key?(:starting_level) ? opts[:starting_level].to_i : 1
      @current_room   = opts.key?(:current_room) ? opts[:current_room] : nil
      @current_room   = Room.new('Void', 'A large nothingness.') unless @current_room.is_a? Room
      @global_vars    = opts.key?(:global_vars) ? opts[:global_vars].to_h : {}
    end

    # TODO: continue Adventure entity definitions.
  end
end
