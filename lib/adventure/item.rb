# frozen_string_literal: true

module Adventure
  # Represents an ingame item.
  class Item
    # Item's type, either one of {Adventure::Item::Type}
    # or a String.
    attr_reader :type
    # Item's type of damage.
    attr_reader :dmg_type
    # Item's rarity, if applicable. Either one of
    # {Adventure::Item::Rarity}, a String, or
    # `nil` when unset.
    attr_reader :rarity
    # Whether the item requires attunement or not. If
    # a string, it will be prepended by *"Requires attunement "*.
    attr_reader :attunement
    # Whether the item is identified (known) or not.
    attr_reader :known
    # The value of the item, a Float representing
    # such value in gold pieces, or `nil` when unset.
    attr_accessor :value
    # The weight of the item, a Float in **kilograms**,
    # or `nil` when unset.
    attr_accessor :weight
    # The source of the item, a String, with source
    # name and page when applicable, or `nil` when
    # unset.
    attr_accessor :source

    # Types of items.
    module Type
      # Ammunition item type.
      AMMUNITION     = 'Ammunition'
      # Artisan\'s Tools item type.
      TOOLS_ARTISAN  = 'Artisan\'s Tools'
      # Explosive item type.
      EXPLOSIVE      = 'Explosive'
      # Firearm item type.
      FIREARM        = 'Firearm'
      # Food & Drink item type.
      FOOD           = 'Food & Drink'
      # Food & Drink item type.
      DRINK          = 'Food & Drink'
      # Gaming Set item type.
      GAME           = 'Gaming Set'
      # Heavy Armor item type.
      ARMOR_HEAVY    = 'Heavy Armor'
      # Instrument item type.
      INSTRUMENT     = 'Instrument'
      # Light Armor item type.
      ARMOR_LIGHT    = 'Light Armor'
      # Martial Weapon item type.
      WEAPON_MARTIAL = 'Martial Weapon'
      # Medium Armor item type.
      ARMOR_MEDIUM   = 'Medium Armor'
      # Melee Weapon item type.
      WEAPON_MELEE   = 'Melee Weapon'
      # Spellcasting Focus item type.
      FOCUS          = 'Spellcasting Focus'
      # Staff item type.
      STAFF          = 'Staff'
      # Tack & Harness item type.
      HARNESS        = 'Tack & Harness'
      # Tatoo item type.
      TATOO          = 'Tatoo'
      # Tool item type.
      TOOL           = 'Tool'
      # Trade Good item type.
      TRADE          = 'Trade Good'
      # Treasure (Art Object) item type.
      ART            = 'Treasure (Art Object)'
      # Treasure (Coinage) item type.
      COINAGE        = 'Treasure (Coinage)'
      # Treasure (Gemstone) item type.
      GEMSTONE       = 'Treasure (Gemstone)'
      # Vehicle (Air) item type.
      VEHICLE_AIR    = 'Vehicle (Air)'
      # Vehicle (Land) item type.
      VEHICLE_LAND   = 'Vehicle (Land)'
      # Vehicle (Space) item type.
      VEHICLE_SPACE  = 'Vehicle (Space)'
      # Vehicle (Water) item type.
      VEHICLE_WATER  = 'Vehicle (Water)'
      # Wand item type.
      WAND           = 'Wand'
      # Wondrous Item type.
      WONDROUS       = 'Wondrous Item'
    end

    # Types of damage.
    module DamageType
      # Acid damage type.
      ACID        = 'Acid'
      # Bludgeoning damage type.
      BLUDGEONING = 'Bludgeoning'
      # Cold damage type.
      COLD        = 'Cold'
      # Fire damage type.
      FIRE        = 'Fire'
      # Force damage type.
      FORCE       = 'Force'
      # Lightning damage type.
      LIGHTNING   = 'Lightning'
      # Necrotic damage type.
      NECROTIC    = 'Necrotic'
      # Piercing damage type.
      PIERCING    = 'Piercing'
      # Poison damage type.
      POISON      = 'Poison'
      # Psychic damage type.
      PSYCHIC     = 'Psychic'
      # Radiant damage type.
      RADIANT     = 'Radiant'
      # Slashing damage type.
      SLASHING    = 'Slashing'
      # Thunder damage type.
      THUNDER     = 'Thunder'
    end

    # Tiers of rarity.
    module Rarity
      # Common rarity.
      COMMON    = 'Common'
      # Uncommon rarity.
      UNCOMMON  = 'Uncommon'
      # Rare rarity.
      RARE      = 'Rare'
      # Very Rare rarity.
      VERY_RARE = 'Very Rare'
      # Legendary rarity.
      LEGENDARY = 'Legendary'
      # Artifact rarity.
      ARTIFACT  = 'Artifact'
      # Unknown rarity.
      UNKNOWN   = 'Unknown'
    end

    # Possible item properties.
    module Property
      # Ammunition item property.
      AMMUNITION     = 'Ammunition'
      # Armor-Piercing item property.
      ARMOR_PIERCING = 'Armor-Piercing'
      # Blackpowder item property.
      BLACKPOWDER    = 'Blackpowder'
      # Burst Fire item property.
      BURST_FIRE     = 'Burst Fire'
      # Cumbersome item property.
      CUMBERSOME     = 'Cumbersome'
      # Damage item property.
      DAMAGE         = 'Damage'
      # Double item property.
      DOUBLE         = 'Double'
      # Finesse item property.
      FINESSE        = 'Finesse'
      # Hafted item property.
      HAFTED         = 'Hafted'
      # Heavy item property.
      HEAVY          = 'Heavy'
      # Light item property.
      LIGHT          = 'Light'
      # Loading item property.
      LOADING        = 'Loading'
      # Magazine item property.
      MAGAZINE       = 'Magazine'
      # Momentum item property.
      MOMENTUM       = 'Momentum'
      # Reach item property.
      REACH          = 'Reach'
      # Reload item property.
      RELOAD         = 'Reload'
      # Repeater item property.
      REPEATER       = 'Repeater'
      # Thrown item property.
      THROWN         = 'Thrown'
      # Two-Handed item property.
      TWO_HANDED     = 'Two-Handed'
      # Versatile item property.
      VERSATILE      = 'Versatile'
      # Special item property.
      SPECIAL        = 'Special'
    end

    # Create a new instance of Item.
    #
    # @param    name         [String]         Item's name.
    # @param    description  [String]         Item's full description, in GFM.
    # @param    type         [Type, String]   Item's type from the {Type} list, or a String.
    # @param    options      [Hash]           A list of optional parameters.
    # @option   options  [Rarity, String]  :rarity          Item's rarity. Either one of Adventure::Item::Rarity or a String, or `nil` when unset.
    # @option   options  [Float]           :value           Item's value in *gold pieces* (`gp`). Fractional values represent the `gp` equivalent of `sp`s and `cp`s.
    # @option   options  [Float]           :weight          Item's weight in **kilograms**.
    # @option   options  [String]          :source          Item's source and page.
    # @option   options  [Integer]         :ac              Item's AC bonus.
    # @option   options  [Boolean]         :max_dex_bonus   If this item is an armor, the maximum Dexterity bonus applicable to the AC.
    # @option   options  [String]          :dmg_notation    The damage notation in the format `XdY+Z`.
    # @option   options  [Integer]         :dmg_die_count   The X in the notation `XdY+Z`, for damage.
    # @option   options  [Integer]         :dmg_die_type    The Y in the notation `XdY+Z`, for damage.
    # @option   options  [Integer]         :dmg_mod         The Z in the notation `XdY+Z`, for damage.
    # @option   options  [DamageType]      :dmg_type        Item's type of damage.
    # @option   options  [Boolean]         :magic           Whether or not the item is of magical nature.
    # @option   options  [Boolean, String] :attunement      Whether the item requires attunement or not. If a string, it will be prepended by *"Requires attunement "*.
    # @option   options  [Boolean]         :known           Whether or not the object is a known one. Defaults to `true`.
    # @option   options  [String]          :unknown_name    The name to be shown, if the object is unkown.
    # @option   options  [Array<Property>] :properties      An array of properties.
    def initialize(name, description, type, **options)
      # Mandatory parameters
      @name            = name.strip
      @description     = description.strip
      @type            = type
      # Optional parameters
      # > General properties.
      @rarity          = options.key?(:rarity) ? options[:rarity] : nil
      @value           = options.key?(:value) ? options[:value].to_f : 0.0
      @weight          = options.key?(:weight) ? options[:weight].to_f : 0.0
      @source          = options.key?(:source) ? options[:source] : nil
      # > Armor properties.
      @ac              = options.key?(:ac) ? options[:ac] : nil
      @max_dex_bonus   = options.key?(:max_dex_bonus) ? options[:max_dex_bonus].to_i : 1_000
      # > Weapon properties.
      if options.key?(:dmg_notation) && !options[:dmg_notation].strip.empty?
        @dmg_die_count, @dmg_die_type, @dmg_mod = parse_damage_notation(options[:dmg_notation].strip)
      else
        @dmg_die_count = options.key?(:dmg_die_count) ? options[:dmg_die_count].to_i : 0
        @dmg_die_type  = options.key?(:dmg_die_type) ? options[:dmg_die_type].to_i : 0
        @dmg_mod       = options.key?(:dmg_mod) ? options[:dmg_mod].to_i : 0
      end
      @dmg_type        = options.key?(:dmg_type) ? options[:dmg_type] : nil
      # > Magic properties.
      @magic           = options.key?(:magic) || false
      @rarity          = Rarity::UNKNOWN if @magic && @rarity.nil?
      if options.key?(:attunement)
        @attunement    = 'Requires attunement'
        @attunement   += " #{options[:attunement].strip}" if options[:attunement].is_a?(String)
      else
        @attunement    = ''
      end
      # > Unkown properties.
      @known           = options.key?(:known) ? (options[:known] == true) : true
      @unknown_name    = options.key?(:unknown_name) ? options[:unknown_name].strip : "Unknown #{@type}"
      @unknown_desc    = options.key?(:unknown_desc) ? options[:unknown_desc].strip : "Unknown #{@type}."
      # > Misc properties.
      @properties      = options.key?(:properties) ? options[:properties] : nil
    end

    # Return a String with the item's name, or its placeholder if unknown.
    #
    # @return         [String]         A String with the item's name, or its placeholder if unknown.
    def name
      @known ? @name : @unknown_name
    end

    # An alias for {::name}.
    #
    # @return         [String]         A String with the item's name, or its placeholder if unknown.
    def to_s
      name
    end

    # Return a Float with the item's weight.
    #
    # @return         [Float]          A String with the item's weight.
    def to_f
      @weight
    end

    # Return a String with the item's description, or its placeholder if unknown.
    #
    # @return         [String]         A String with the item's description, or its placeholder if unknown.
    def description
      @known ? @description : @unknown_desc
    end

    # Return the default RPG notation for damage calculation.
    #
    # This **does not** return actual damage!
    #
    # @return   [String, nil]   The item's damage in standart RPG notation, or nil if not a valid weapon.
    def damage_notation
      if @dmg_die_count.nil? || @dmg_die_type.nil?
        nil
      else
        mod = ''
        if @dmg_mod.negative?
          mod = @dmg_mod.to_s
        elsif @dmg_mod.positive?
          mod = "+#{@dmg_mod}"
        end
        "#{@dmg_die_count}d#{@dmg_die_type}#{mod}"
      end
    end

    # Return the damage dealt by the item this iteration.
    #
    # Each run of this method will return a different
    # number, since each call represents one roll for
    # damage --- which varies, obviously.
    #
    # @return   [Integer, nil]  This iteration's damage dealt by the item, or nil if not a valid weapon
    def damage(advantage: false)
      if @dmg_die_count.zero? || @dmg_die_type.zero?
        nil
      else
        count = advantage ? @dmg_die_count * 2 : @dmg_die_count
        damage = @dmg_mod
        count.times do
          damage += rand(@dmg_die_type) + 1
        end
        damage
      end
    end

    # Whether this item is a weapon or not.
    #
    # @return   [Boolean]   `true` if the item is a weapon and have damage parameters, `false` otherwise.
    def weapon?
      if @type.downcase.include?('weapon') && !damage_notation.nil?
        true
      else
        false
      end
    end

    # Whether this item is magical or not.
    #
    # @return   [Boolean]   `true` if the item is magical, `false` otherwise.
    def magic?
      @magic
    end

    # Whether this item is an armor or not.
    #
    # @return   [Boolean]   `true` if some AC modifier is set, `false` otherwise.
    def armor?
      !@ac.nil?
    end

    # The wearer's AC with this item, if it is an armor, `nil` otherwise.
    #
    # @param    dex_bonus   [Integer, nil]  The wearer's Dexterity bonus.
    # @return   [Integer, nil]              The AC, given the wearer's Dex bonus.
    def ac(dex_bonus = 0)
      return nil unless armor?

      ac = @ac
      ac += [dex_bonus, @max_dex_bonus].min
      ac
    end

    # Alias for {::value}.
    #
    # @return   [Float]                     The value of the item.
    def price
      @value
    end

    # Set the {Item} as known.
    def identify
      @known = true
    end

    private

    # Parse damage notation to actual damage data.
    #
    # @param  notation  [String]  A notation in the format `XdY+Z`.
    def parse_damage_notation(notation)
      if /\d+d\d+([+-]\d+)?/.match?(notation)
        dmg = notation.scan(/(\d+)d(\d+)([+-]\d+)?/)[0]
        dmg.map!(&:to_i)
        dmg
      else
        [nil, nil, 0]
      end
    end
  end
end
