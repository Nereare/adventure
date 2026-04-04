# frozen_string_literal: true

require_relative 'item'

module Adventure
  # Represents an ingame inventory.
  #
  # Extends/includes the Enumerable mixin.
  class Inventory
    include Enumerable

    # How many `kg` can be carryied by point of Strength score, before encumberance sets it.
    KG_PER_STR = 7.0
    # How many `kg` can be dragged by point of Strength score.
    DRAG_KG_PER_STR = 14.0
    # Size modifier for the maximum carrying capacity.
    SIZE_MODIFIER = {
      tiny: 0.5,
      medium: 1.0,
      large: 2.0,
      huge: 4.0,
      gargantuan: 8.0
    }.freeze
    # Valid sizes.
    SIZES = %w(tiny medium large huge gargantuan)

    # This inventory's maximum carrying capacity, **in kilograms**.
    attr_reader :carrying_capacity
    # This inventory's maximum dragging/lifting weight, **in kilograms**.
    attr_reader :drag_weight

    # Create a new instance of Inventory.
    #
    # Accepts **only** {Item}'s as contents.
    def initialize(*items, **opts)
      # Populate Inventory only with {Item}s
      @items             = items#.select { |i| i.is_a? Item }
      # Get parameters
      str                = opts.key?(:str) ? opts[:str].to_f : 10
      size               = opts.key?(:size) ? opts[:size].to_sym : :medium
      size               = :medium unless SIZES.include? size
      modifier           = opts.key?(:modifier) ? opts[:modifier].to_f : 1.0
      # Set capacities
      @carrying_capacity = str * KG_PER_STR * SIZE_MODIFIER[size] * modifier
      @drag_weight       = str * DRAG_KG_PER_STR * SIZE_MODIFIER[size] * modifier
    end

    # Run `each` blocks for each item in the Inventory.
    def each(&block)
      @items.each(&block)
    end

    # Return a String with the number of items within.
    #
    # @return         [String]    The String "Inventory containing X item(s)", with X being the item count and "item" word being pluralized accordingly.
    def to_s
      "Inventory containing #{@items.count} item#{@items.count > 1 ? 's' : ''}"
    end

    # Return an Array equivalent of the Inventory. This
    # Array is a list of the name of each Item within.
    #
    # @return         [Array<String>]   An Array of Strings, each String being the name of an {Item} within.
    def to_a
      @items.map { |i| i.name }
    end

    # Return the number of items within the Inventory.
    #
    # @return         [Integer]   The number of items within the Inventory.
    def to_i
      @items.count
    end

    # Get the total carried weight of the Inventory.
    #
    # @return         [Float]   The total carried weight, in **kilograms**.
    def carried_weight
      @items.sum { |i| i.weight }
    end

    # Get whether or not this Inventory is carrying items
    # with a total weight over its Carrying Capacity --- *i.e.*
    # the Inventory imposes encumberance.
    #
    # @return         [Boolean]   Whether or not this Inventory is emposing encumberance.
    def encumbered?
      carried_weight > @carrying_capacity
    end

    # Get whether or not this Inventory is carrying items
    # with a total weight over its Drag limit --- *i.e.*
    # the Inventory cannot be carried, only dragged.
    #
    # @return         [Boolean]   Whether or not this Inventory must be dragged to be moved.
    def dragging?
      carried_weight > @drag_weight
    end
  end
end
