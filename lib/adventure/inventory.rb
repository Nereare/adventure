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
    SIZES = %w[tiny medium large huge gargantuan].freeze

    # This inventory's maximum carrying capacity, **in kilograms**.
    attr_reader :carrying_capacity
    # This inventory's maximum dragging/lifting weight, **in kilograms**.
    attr_reader :drag_weight

    # Create a new instance of Inventory.
    #
    # Accepts **only** {Item}'s as contents.
    #
    # @param  items   [Array<Item>]       A list of comma-separated {Item}s.
    # @param  opts    [Hash]              A list of optional parameters.
    # @option opts    [Float]   str       The Strength score of this {Inventory}'s holder.
    # @option opts    [Symbol]  size      The size of this {Inventory}'s holder.
    # @option opts    [Float]   modifier  Any other miscellaneous modifier to the carrying capacity.
    # @see SIZES
    def initialize(*items, **opts)
      # Populate Inventory only with {Item}s
      @items             = items.grep(Item)
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
    def each(&)
      @items.each(&)
    end

    # Return a String with the number of items within.
    #
    # @return         [String]    The String "Inventory containing X item(s)", with X being the item count and "item" word being pluralized accordingly.
    def to_s
      "Inventory containing #{@items.count} item#{'s' if @items.count > 1}"
    end

    # Return an Array equivalent of the Inventory. This
    # Array is a list of the name of each Item within.
    #
    # @return         [Array<String>]   An Array of Strings, each String being the name of an {Item} within.
    def to_a
      @items.map(&:name)
    end

    # Fetches the Inventory as an Array (through the inner
    # {to_a} method) and returns such Array joined by the
    # given separator.
    #
    # @param  separator   [String]      The string to join the array by.
    # @return             [String]      A string of the name of each {Item}, separated by the given String.
    def join(separator = ', ')
      to_a.join(separator)
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
      @items.sum(&:weight)
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

    # Get the first {Item} whose name includes the given
    # String.
    #
    # This method is case-**insensitive**.
    #
    # @param  item    [String]    A full or partial name to search an {Item} by.
    # @return         [Item, nil] Either the first {Item} whose name matches the given String, or `nil` if there is no match.
    def get(item)
      @items.find { |i| i.name.downcase.include? item.downcase }
    end

    # Include a new item to the {Inventory}.
    #
    # @param  item    [Item]      The {Item} to be added.
    def add(item)
      raise ArgumentError, 'Item to be added is not an Item.' unless item.is_a? Item

      @items.push item
    end

    # Remove the first {Item} whose name includes the
    # given String.
    #
    # This method is case-insensitive and finds the {Item}
    # through the {get} method.
    #
    # @param  item    [String]    A full or partial name to search the {Item} to be removed by.
    # @return         [Item, nil] Either the removed {Item}, or `nil` if no such {Item}.
    def remove(item)
      trash = get(item)
      @items.delete trash
    end
  end
end
