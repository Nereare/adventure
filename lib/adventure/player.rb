# frozen_string_literal: true

module Adventure
  # Represents the game player.
  class Player
    # The player's name.
    attr_reader :name
    # The player's total level.
    attr_reader :level
    # The player's classes.
    attr_reader :classes
    # The player's species.
    attr_reader :species
    # The player's gender.
    attr_reader :gender
    # The player's {Purse}.
    attr_reader :purse
    # The player's {Inventory}.
    attr_reader :inventory

    # Create a new instance of Player.
    #
    # @param    name       [String]                 The player's name.
    # @param    classes    [Array<String>]          The player's list of classes, as an Array of Strings.
    # @param    species    [String]                 The player's species.
    # @param    opts       [Hash]                   A list of optional parameters.
    # @param    opts       [Integer]    :level      The player's total level. Defaults to `1`.
    # @option   opts       [Purse]      :purse      The player's {Purse}. Will be set to an empty {Purse} if unset.
    # @option   opts       [Inventory]  :inventory  The player's {Inventory}. Will be set to an empty {Inventory} if unset.
    def initialize(name, classes, species, gender, **opts)
      # Mandatory parameters.
      @name      = name.strip
      @classes   = classes.to_a.map(&:strip).map(&:capitalize)
      @species   = species.strip.capitalize
      @gender    = gender.strip.capitalize
      # Optional parameters.
      @level     = opts.key?(:level) ? opts[:level].to_i : 1
      @purse     = opts.key?(:purse) ? opts[:purse] : nil
      @purse     = Purse.new unless @purse.is_a? Purse
      @inventory = opts.key?(:inventory) ? opts[:inventory] : nil
      @inventory = Inventory.new unless @inventory.is_a? Inventory
    end

    # Return a String with the player's name, gender, species, and total level.
    #
    # @return         [String]         A String with the player's name, gender, species, and total level.
    def to_s
      "#{@name}, #{@gender.downcase} #{@species.downcase}, level #{@level}"
    end

    # Return an Integer as the player's total level.
    #
    # @return         [Integer]        The player's total level.
    def to_i
      @level
    end

    # Bump the player's level by `1`.
    #
    # @return         [Integer]        The player's new total level.
    def level_up
      @level += 1
      @level
    end

    # Add a new class to the player and levels them up.
    #
    # @return         [Array<String>]  The player's new list of classes.
    def new_class(new_class)
      @classes.push new_class.strip.capitalize
      level_up
      @classes
    end
  end
end
