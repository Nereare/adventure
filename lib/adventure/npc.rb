# frozen_string_literal: true

module Adventure
  # Represents an ingame Non-Playable Character (NPC).
  class NPC
    # @!attribute [r]              name
    #   @return   [String]         The NPC's name.
    attr_reader :name
    # @!attribute [r]              species
    #   @return   [String]         The NPC's species.
    attr_reader :species
    # @!attribute [r]              gender
    #   @return   [String]         The NPC's gender.
    attr_reader :gender
    # @!attribute [r]              friendship
    #   @return   [String]         The NPC's friendship level.
    attr_reader :friendship
    # @!attribute [r]              purse
    #   @return   [{Purse}]        The NPC's {Purse}.
    attr_reader :purse
    # @!attribute [r]              inventory
    #   @return   [{Inventory}]    The NPC's {Inventory}.
    attr_reader :inventory
    # @!attribute [rw]             dialogue
    #   @return   [Array<Hash>]    The NPC's list of conversation options. Each Hash must contain exactly two entries: a `question` and a `reply`.
    attr_accessor :dialogue

    # Levels of friendship, based on Likert scale.
    module FriendshipLevel
      # Hate friendship level - will go out of their way to harm the {Player}.
      HATE    = 1
      # Dislike friendship level - won't help the {Player}, but won't go out of their way to harm them.
      DISLIKE = 2
      # Neutral friendship level - won't help nor hinder the {Player} in anyway.
      NEUTRAL = 3
      # Like friendship level - will do small things to help the {Player}, but never to their disadvantage.
      LIKE    = 4
      # Love (not necessarily romantic!) friendship level - will help the {Player} in any way they can, sometimes even subjecting themselves to harm.
      LOVE    = 5
    end

    # Create a new instance of NPC.
    #
    # @param    name       [String]                    The NPC's name.
    # @param    species    [String]                    The NPC's species.
    # @param    gender     [String]                    The NPC's gender.
    # @param    opts       [Hash]                      A list of optional parameters.
    # @option   opts       [Integer]      :friendship  The NPC's attitude towards the player, from 1 (hate) to 5 (love). Use {Adventure::NPC::FriendshipLevel} for readability.
    # @option   opts       [{Purse}]      :purse       The NPC's {Purse}. Will be set to an empty {Purse} if unset.
    # @option   opts       [{Inventory}]  :inventory   The NPC's {Inventory}. Will be set to an empty {Inventory} if unset.
    # @option   opts       [Array<Hash>]  :dialogue    The NPC's list of conversation options.
    def initialize(name, species, gender, **opts)
      # Mandatory parameters.
      @name       = name.strip
      @species    = species.strip.capitalize
      @gender     = gender.strip.capitalize
      # Optional parameters.
      @friendship = opts.key?(:friendship) ? opts[:friendship].to_i : FriendshipLevel::NEUTRAL
      @purse      = opts.key?(:purse) ? opts[:purse] : nil
      @purse      = Purse.new unless @purse.is_a? Purse
      @inventory  = opts.key?(:inventory) ? opts[:inventory] : nil
      @inventory  = Inventory.new unless @inventory.is_a? Inventory
      @dialogue   = opts.key?(:dialogue) ? opts[:dialogue].to_a : []
    end

    # Return a String with the NPC's name, gender, and species.
    #
    # @return         [String]         A String with the NPC's name, gender, and species.
    def to_s
      "#{@name}, #{@gender.downcase} #{@species.downcase}"
    end

    # Return an Integer as the NPC's friendship level towards the {Player}.
    #
    # @return         [Integer]        The NPC's friendship level.
    def to_i
      @friendship
    end

    # Bump the NPC's friendship level by `1`, to a maximum of `5`.
    #
    # @return         [Integer]        The NPC's new friendship level.
    def charm
      @friendship += 1 unless @friendship >= 5
      @friendship
    end

    # Nerf the NPC's friendship level by `1`, to a minimum of `1`.
    #
    # @return         [Integer]        The NPC's new friendship level.
    def offend
      @friendship -= 1 unless @friendship <= 1
      @friendship
    end
  end
end
