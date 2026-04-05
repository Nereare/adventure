# frozen_string_literal: true

require_relative 'inventory'

module Adventure
  # Gem's name.
  class Room
    # List of valid directions.
    DIRECTIONS = %i[north northeast east southeast south southwest west northwest up down].freeze

    # Room's name.
    attr_reader :name
    # Room's long description.
    attr_reader :description
    # Room's short description.
    attr_reader :short_description
    # Room's exit.
    attr_reader :exits
    # Room's {Inventory}.
    attr_reader :inventory

    # Create a new instance of Room.
    #
    # @param    name          [String]   The room's name.
    # @param    description   [String]   The room's long description.
    # @param    opts          [Hash]     A list of optional parameters.
    # @option   opts          [String]      short_description   The room's description, but shorter.
    # @option   opts          [Boolean]     lit                 Whether or not this room is alight, `true` by default.
    # @option   opts          [Hash]        exits               A Hash of exits (other {Room}s), keyed by direction's Symbol.
    # @option   opts          [Inventory]   contents            The room's {Item} contents, empty {Inventory} by default.
    # @see DIRECTIONS
    def initialize(name, description, **opts)
      # Obligatory parameters
      @name        = name
      @description = description
      # Other, optional, parameters
      @short_desc  = opts.key?(:short_description) ? opts[:short_description].trim : nil
      @lit         = opts.key?(:lit) ? opts[:lit] : true
      @exits       = opts.key?(:exits) ? opts[:exits].to_h : {}
      @inventory   = opts.key?(:inventory) ? opts[:inventory] : Inventory.new
      # TODO: implement battles and/or monsters.
    end

    # Returns this room's name, or "Dark Room" if unlit.
    def to_s
      @lit ? @name : 'Dark Room'
    end

    # Returns a description of the contents of this {Room},
    # or a filler text if it is dark/unlit.
    #
    # The default text is:
    #
    # > `:name` contains `:items`.
    #
    # Where `:name` is replaced by this room's name, and
    # `:items` by a list of its contents.
    #
    # The default text for a dark room is:
    #
    # > You can see no contents.
    #
    # @param    opts    [Hash]                  A list of optional parameters.
    # @option   opts    [String]  :base_text    The text to describe the contents of a lit room, where you can use `:name` and `:items` as placeholders as described above.
    # @option   opts    [String]  :dark_text    The text (not) to describe the contents of a unlit room, this text accepts **no placeholders**.
    # @option   opts    [String]  :separator    The separator to join the list of this room's items by. **This** text has no whitespaces trimmed as to not remove necessary spaces, newlines, and the like --- so beware of extra, unintended spaces!
    # @option   opts    [String]  :no_items     A text to use in place of `:items` if the room has no {Item}s within.
    def contents(**opts)
      # Fetch optional parameters
      base_text = opts.key?(:base_text) ? opts[:base_text].trim : ':name contains :items.'
      dark_text = opts.key?(:dark_text) ? opts[:dark_text].trim : 'You can see no contents.'
      separator = opts.key?(:separator) ? opts[:separator] : ', '
      no_items  = opts.key?(:no_items) ? opts[:no_items].trim : 'no items'
      # Process texts into a room's contents description
      items = @inventory.to_i.positive? ? @inventory.join(separator) : no_items
      base_text.gsub!(':name', @name).gsub!(':items', items)

      # Return description accordingly
      @lit ? base_text : dark_text
    end

    # Returns the corresponding exit.
    #
    # @param    direction     [Symbol,String]   The direction to which fetch the exit. Either a one-word cardinal direction, or a corresponding Symbol.
    # @return                 [Room, nil]       Either the corresponding exit, or `nil` if no exit to that direction.
    def exit(direction)
      direction = direction.downcase.to_sym
      @exits[direction.to_sym]
    end

    # Shorthand for {exit} with `:north` as direction.
    #
    # @return                 [Room, nil]       Either the north exit, or `nil` if no exit to that direction.
    def north
      exit(:north)
    end

    # Shorthand for {exit} with `:northeast` as direction.
    #
    # @return                 [Room, nil]       Either the northeast exit, or `nil` if no exit to that direction.
    def northeast
      exit(:northeast)
    end

    # Shorthand for {exit} with `:east` as direction.
    #
    # @return                 [Room, nil]       Either the east exit, or `nil` if no exit to that direction.
    def east
      exit(:east)
    end

    # Shorthand for {exit} with `:southeast` as direction.
    #
    # @return                 [Room, nil]       Either the southeast exit, or `nil` if no exit to that direction.
    def southeast
      exit(:southeast)
    end

    # Shorthand for {exit} with `:south` as direction.
    #
    # @return                 [Room, nil]       Either the south exit, or `nil` if no exit to that direction.
    def south
      exit(:south)
    end

    # Shorthand for {exit} with `:southwest` as direction.
    #
    # @return                 [Room, nil]       Either the southwest exit, or `nil` if no exit to that direction.
    def southwest
      exit(:southwest)
    end

    # Shorthand for {exit} with `:west` as direction.
    #
    # @return                 [Room, nil]       Either the west exit, or `nil` if no exit to that direction.
    def west
      exit(:west)
    end

    # Shorthand for {exit} with `:northwest` as direction.
    #
    # @return                 [Room, nil]       Either the northwest exit, or `nil` if no exit to that direction.
    def northwest
      exit(:northwest)
    end

    # Shorthand for {exit} with `:up` as direction.
    #
    # @return                 [Room, nil]       Either the up exit, or `nil` if no exit to that direction.
    def up
      exit(:up)
    end

    # Shorthand for {exit} with `:down` as direction.
    #
    # @return                 [Room, nil]       Either the down exit, or `nil` if no exit to that direction.
    def down
      exit(:down)
    end
  end
end
