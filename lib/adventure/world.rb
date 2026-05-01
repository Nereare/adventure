# frozen_string_literal: true

require 'psych'

require_relative 'being'
require_relative 'inventory'
require_relative 'item'
# require_relative 'player'
require_relative 'purse'
require_relative 'room'

module Adventure
  # Represents the world where the game takes place.
  class World
    # The adventure's title / name.
    attr_reader :title
    # The adventure's subtitle / flavor text.
    attr_reader :subtitle
    # An Array of authors, in the format `Name <email> (url)`.
    attr_reader :authors
    # The full name of the license the adventure is released under.
    attr_reader :license
    # The year (or years) of development of the adventure.
    attr_reader :year
    # A description of the adventure.
    attr_reader :description
    # The adventure's player object.
    attr_reader :player
    # The index of the game's current Room, initially the starting Room.
    attr_reader :current_room
    # A Hash of variables to be used by the adventure --- currently unused, kept as placeholder.
    attr_reader :global_vars

    # Create a new game instance - a new World.
    #
    # @param  opts    [Hash]            A list of named parameters.
    # @option opts    [String]          title           The adventure's title / name.
    # @option opts    [String,nil]      subtitle        The adventure's subtitle / flavor text.
    # @option opts    [Array<String>]   authors         An Array of authors, in the format `Name <email> (url)`.
    # @option opts    [String]          license         The full name of the license the adventure is released under.
    # @option opts    [String]          year            The year (or years) of development of the adventure.
    # @option opts    [String]          description     A description of the adventure.
    # @option opts    [Player]          player          The adventure's player object.
    # @option opts    [Hash]            atlas           An Array of all the rooms for the adventure.
    # @option opts    [Integer,Symbol]  current_room    The index of the game's current Room, initially the starting Room.
    # @option opts    [Hash]            global_vars     A Hash of variables to be used by the adventure --- currently unused, kept as placeholder.
    def initialize(**opts)
      @title        = opts.key?(:title) ? opts[:title].trim : ''
      @subtitle     = opts.key?(:subtitle) ? opts[:subtitle].trim : nil
      @authors      = opts.key?(:authors) ? opts[:authors].to_a : []
      @license      = opts.key?(:license) ? opts[:license].trim : 'Creative Commons 0 1.0 Universal'
      @year         = opts.key?(:year) ? opts[:year].trim : Date.today.year.to_s
      @description  = opts.key?(:description) ? opts[:description].trim : ''
      @player       = opts.key?(:player) ? opts[:player].to_i : nil
      @atlas        = opts.key?(:atlas) ? opts[:atlas].to_a : []
      @current_room = opts.key?(:current_room) ? opts[:current_room].to_i : 0
      @global_vars  = opts.key?(:global_vars) ? opts[:global_vars].to_h : {}
    end

    # Class method

    def self.load(file)
      yaml = Psych.safe_load_file(
        file,
        permitted_classes: [
          Adventure::Being,
          Adventure::Inventory,
          Adventure::Item,
          # Adventure::Player,
          Adventure::Purse,
          Adventure::Room,
          Adventure::World
        ],
        aliases: true
      )
      raise StandardError, 'Invalid input.' if yaml.nil?
      yaml
    end

    # Instance methods

    def save(file)
      yaml = Psych.safe_dump(
        self,
        permitted_classes: [
          Adventure::Being,
          Adventure::Inventory,
          Adventure::Item,
          # Adventure::Player,
          Adventure::Purse,
          Adventure::Room,
          Adventure::World
        ]
      )
      File.write(file, yaml)
    end

    # TODO: continue World entity definitions.
  end
end
