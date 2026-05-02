# frozen_string_literal: true

module Adventure
  # Represents any ingame being.
  #
  # By being, this means any creature, plant, fungus,
  # NPC, Player, or thing that has a monster stat
  # block.
  #
  # This class implements basic D&D stat management
  # functionalities, as well as battle capabilities.
  class Being
    # List of all valid abilities.
    ABILITIES = %i[str dex con int wis cha].freeze
    # List of all valid skills.
    SKILLS = %i[acrobatics animal_handling arcana athletics deception history insight intimidation investigation medicine nature perception performance persuasion religion sleight_hand stealth survival].freeze
    SIZES = %w[Fine Diminutive Tiny Small Medium Large Huge Gargantuan Colossal].freeze
    TYPES = %w[Aberration Animal Beast Celestial Construct Dragon Elemental Fey Fiend Giant Humanoid Ooze Outsider Plant Undead Vermin].freeze

    # Being's name.
    attr_reader :name
    # Being's source text, when applicable.
    attr_reader :source
    # Being's alignment.
    attr_reader :align
    # Being's Challenge Rating.
    attr_reader :cr
    # Being's Proficiency bonus.
    attr_reader :proficiency
    # Being's Hash of levels by, when applicable, class, or Integer of total level.
    attr_reader :levels
    # Being's size.
    attr_reader :size
    # Being's type.
    attr_reader :type
    # Being's subtype, if any.
    attr_reader :subtype
    # Whether or not this is a swarm of beings.
    attr_reader :swarm
    # Being's Hash of speeds, with five elements representing walk, burrow, climb, fly, and swim speeds -- the ones that don't apply set to `nil`.
    attr_reader :speed
    # Being's Array of senses, empty by default.
    attr_reader :senses
    # Being's Array of known languages.
    attr_reader :languages
    # Being's Strength score.
    attr_reader :str
    # Being's Dexterity score.
    attr_reader :dex
    # Being's Constitution score.
    attr_reader :con
    # Being's Intelligence score.
    attr_reader :int
    # Being's Wisdom score.
    attr_reader :wis
    # Being's Charisma score.
    attr_reader :cha
    # Being's Passive Perception score.
    attr_reader :passive_perception
    # Being's Armor Class.
    attr_reader :ac
    # Being's AC description, if any.
    attr_reader :ac_desc
    # Being's total/maximum Hit Points.
    attr_reader :hp
    # Being's current HP, initialized as the same as maximum HP.
    attr_reader :current_hp
    # Being's HP dice formula.
    attr_reader :hp_formula
    # Being's Array of Damage Vulnerabilities, if any -- empty by default.
    attr_reader :dmg_vulnerabilities
    # Being's Array of Damage Resistances, if any -- empty by default.
    attr_reader :dmg_resistances
    # Being's Array of Damage Immunities, if any -- empty by default.
    attr_reader :dmg_immunities
    # Being's Array of Condition Immunities, if any -- empty by default.
    attr_reader :condition_immunities
    # Being's Spellcasting block header -- `nil` if not applicable.
    attr_reader :spell_header
    # Being's Spellcasting block footer -- `nil` if not applicable.
    attr_reader :spell_footer
    # Being's Spellcasting array of spells -- empty by default.
    attr_reader :spell_list
    # Being's Array of Traits.
    attr_reader :traits
    # Being's Actions' header.
    attr_reader :actions_header
    # Being's Array of Actions.
    attr_reader :actions_list
    # Being's Bonus Actions' header.
    attr_reader :bonus_actions_header
    # Being's Array of Bonus Actions.
    attr_reader :bonus_actions_list
    # Being's Reactions' header.
    attr_reader :reactions_header
    # Being's Array of Reactions.
    attr_reader :reactions_list
    # Being's Legendary Actions' header.
    attr_reader :legendary_actions_header
    # Being's number of Legendary Actions, as Integer.
    attr_reader :legendary_actions_count
    # Being's Array of Legendary Actions.
    attr_reader :legendary_actions_list
    # Being's Mythic Actions' header.
    attr_reader :mythic_actions_header
    # Being's Array of Mythic Actions.
    attr_reader :mythic_actions_list
    # Being's list of {Item}s.
    attr_reader :inventory
    # Being's {Purse}.
    attr_reader :purse
    # Being's flavor description/informations.
    attr_reader :description
    # Being's Array of environments.
    attr_reader :environment

    # Create a new instance of Being.
    #
    # @param   name  [String] The being's name.
    # @param   opts  [Hash]   A list of parameters.
    # @option  opts  [String]               :name                      Being's name.
    # @option  opts  [String]               :source                    Being's source text, when applicable.
    # @option  opts  [String]               :align                     Being's alignment.
    # @option  opts  [Float]                :cr                        Being's Challenge Rating.
    # @option  opts  [Hash]                 :levels                    Being's Hash of levels by, when applicable, class, or Integer of total level.
    # @option  opts  [String]               :size                      Being's size.
    # @option  opts  [String]               :type                      Being's type.
    # @option  opts  [Boolean]              :swarm                     Whether or not this is a swarm of beings.
    # @option  opts  [Hash]                 :speed                     Being's Hash of speeds, with five elements representing walk, burrow, climb, fly, and swim speeds -- the ones that don't apply set to `nil`.
    # @option  opts  [Array<String>]        :senses                    Being's Array of senses, empty by default.
    # @option  opts  [Array<String>]        :languages                 Being's Array of known languages.
    # @option  opts  [Boolean]              :rand_abilities            Whether or not to roll random ability stats -- if set, the initializer ignores any plainly given ability stat.
    # @option  opts  [Array<Symbol>]        :ability_preferences       An array of prioritary abilities, from most importante (index = `0`) to least (last index).
    # @option  opts  [Integer]              :ability_min               The minimum value an ability can be, used only when randomly generating ability scores.
    # @option  opts  [Integer]              :ability_max               The maximum value an ability can be, used only when randomly generating ability scores.
    # @option  opts  [Integer]              :str                       Being's Strength score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :dex                       Being's Dexterity score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :con                       Being's Constitution score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :int                       Being's Intelligence score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :wis                       Being's Wisdom score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :cha                       Being's Charisma score, defaults to `10`, it unset.
    # @option  opts  [Array<Symbol>]        :saves                     Being's Saving Throw proficiencies, as an Array of Symbol's for each proficient save.
    # @option  opts  [Array<Symbol>]        :skills                    Being's Skill proficiencies, as an Array of Symbol's for each proficient skill.
    # @option  opts  [Array<Symbol>]        :skills_expertise          Being's Skill expertises, as an Array of Symbol's for each proficient skill.
    # @option  opts  [Integer]              :ac                        Being's Armor Class.
    # @option  opts  [String]               :ac_desc                   Being's AC description, if any.
    # @option  opts  [Integer]              :hp                        Being's total/maximum Hit Points.
    # @option  opts  [String]               :hp_formula                Being's HP dice formula.
    # @option  opts  [Array<String>]        :dmg_vulnerabilities       Being's Array of Damage Vulnerabilities, if any -- empty by default.
    # @option  opts  [Array<String>]        :dmg_resistances           Being's Array of Damage Resistances, if any -- empty by default.
    # @option  opts  [Array<String>]        :dmg_immunities            Being's Array of Damage Immunities, if any -- empty by default.
    # @option  opts  [Array<String>]        :condition_immunities      Being's Array of Condition Immunities, if any -- empty by default.
    # @option  opts  [String]               :spell_header              Being's Spellcasting block header -- `nil` if not applicable.
    # @option  opts  [String]               :spell_footer              Being's Spellcasting block footer -- `nil` if not applicable.
    # @option  opts  [Array<Hash>]          :spell_list                Being's Spellcasting array of spells -- empty by default.
    # @option  opts  [Array<Hash>]          :traits                    Being's array of traits.
    # @option  opts  [String]               :actions_header            Being's Actions' header.
    # @option  opts  [Array]                :actions_list              Being's Array of Actions.
    # @option  opts  [String]               :bonus_actions_header      Being's Bonus Actions' header.
    # @option  opts  [Array]                :bonus_actions_list        Being's Array of Bonus Actions.
    # @option  opts  [String]               :reactions_header          Being's Reactions' header.
    # @option  opts  [Array]                :reactions_list            Being's Array of Reactions.
    # @option  opts  [String]               :legendary_actions_header  Being's Legendary Actions' header.
    # @option  opts  [Integer]              :legendary_actions_count   Being's number of Legendary Actions, as Integer.
    # @option  opts  [Array]                :legendary_actions_list    Being's Array of Legendary Actions.
    # @option  opts  [String]               :mythic_actions_header     Being's Mythic Actions' header.
    # @option  opts  [Array]                :mythic_actions_list       Being's Array of Mythic Actions.
    # @option  opts  [Array]                :inventory                 Being's {Inventory}.
    # @option  opts  [Purse]                :purse                     Being's {Purse}.
    # @option  opts  [String]               :description               Being's flavor description/informations.
    # @option  opts  [Array]                :environment               Being's Array of environments.
    def initialize(name, **opts)
      @name                     = name.strip
      @source                   = opts.key?(:source) ? opts[:source].strip : nil
      @align                    = opts.key?(:align) ? opts[:align].strip : 'Unaligned'
      if opts.key? :cr
        @cr                     = opts.key?(:cr) ? opts[:cr].to_f : 0.0
        @levels                 = nil
      else
        @cr                     = nil
        @levels                 = opts.key?(:levels) ? opts[:levels].to_a : {}
      end
      @proficiency              = if @levels.nil?
                                    proficiency_bonus(@cr.to_i)
                                  else
                                    proficiency_bonus(@levels)
                                  end
      @size                     = opts.key?(:size) ? opts[:size].strip.capitalize : nil
      @size                     = 'Medium' unless SIZES.include? @size
      @type                     = opts.key?(:type) ? opts[:type].strip.capitalize : nil
      @type                     = 'Humanoid' unless TYPES.include? @type
      @subtype                  = opts.key?(:subtype) ? opts[:subtype].strip.capitalize : ''
      @swarm                    = opts.key?(:swarm) ? (opts[:swarm] == true) : false
      @speed                    = if opts.key?(:speed)
                                    opts[:speed].to_h
                                  else
                                    {
                                      walk: 0,
                                      burrow: 0,
                                      climb: 0,
                                      fly: 0,
                                      swim: 0
                                    }
                                  end
      @senses                   = opts.key?(:senses) ? opts[:senses].to_a : []
      @senses.map!(&:to_s)
      if opts.key? :rand_abilities
        prefs                   = opts.key?(:ability_preferences) ? opts[:ability_preferences].to_a : nil
        min                     = opts.key?(:ability_min) ? opts[:ability_min].to_i : 1
        max                     = opts.key?(:ability_max) ? opts[:ability_max].to_i : 20
        roll_for_abilities(prefs: prefs, min: min, max: max)
      else
        @str                    = opts.key?(:str) ? opts[:@str].to_i : 10
        @dex                    = opts.key?(:dex) ? opts[:@dex].to_i : 10
        @con                    = opts.key?(:con) ? opts[:@con].to_i : 10
        @int                    = opts.key?(:int) ? opts[:@int].to_i : 10
        @wis                    = opts.key?(:wis) ? opts[:@wis].to_i : 10
        @cha                    = opts.key?(:cha) ? opts[:@cha].to_i : 10
      end
      @languages = opts.key?(:languages) ? opts[:languages].to_a : []
      @languages.map!(&:to_s)
      @saves = if opts.key? :saves
                 opts[:saves].to_a.uniq
               else
                 []
               end
      @saves.select! { |save| ABILITIES.include? save }
      @skills                   = if opts.key? :skills
                                    opts[:skills].to_a.uniq
                                  else
                                    []
                                  end
      @skills.select! { |skill| SKILLS.include? skill }
      @skills_expertise         = if opts.key? :skills_expertise
                                    opts[:skills_expertise].to_a.uniq
                                  else
                                    []
                                  end
      @skills_expertise.select! { |skill| SKILLS.include? skill }
      @ac                       = opts.key?(:ac) ? opts[:ac].to_i : 0
      @ac_desc                  = opts.key?(:ac_desc) ? opts[:ac_desc].strip : nil
      @hp                       = opts.key?(:hp) ? opts[:hp].to_i : 0
      @current_hp               = @hp
      @hp_formula               = opts.key?(:hp_formula) ? opts[:hp_formula].strip : nil
      @dmg_vulnerabilities      = opts.key?(:dmg_vulnerabilities) ? opts[:dmg_vulnerabilities].to_a : []
      @dmg_resistances          = opts.key?(:dmg_resistances) ? opts[:dmg_resistances].to_a : []
      @dmg_immunities           = opts.key?(:dmg_immunities) ? opts[:dmg_immunities].to_a : []
      @condition_immunities     = opts.key?(:condition_immunities) ? opts[:condition_immunities].to_a : []
      @spell_header             = opts.key?(:spell_header) ? opts[:spell_header].strip : ''
      @spell_footer             = opts.key?(:spell_footer) ? opts[:spell_footer].strip : ''
      @spell_list               = opts.key?(:spell_list) ? opts[:spell_list].to_a : []
      @traits                   = opts.key?(:traits) ? opts[:traits].to_a : []
      @actions_header           = opts.key?(:actions_header) ? opts[:actions_header].strip : ''
      @actions_list             = opts.key?(:actions_list) ? opts[:actions_list].to_a : []
      @bonus_actions_header     = opts.key?(:bonus_actions_header) ? opts[:bonus_actions_header].strip : ''
      @bonus_actions_list       = opts.key?(:bonus_actions_list) ? opts[:bonus_actions_list].to_a : []
      @reactions_header         = opts.key?(:reactions_header) ? opts[:reactions_header].strip : ''
      @reactions_list           = opts.key?(:reactions_list) ? opts[:reactions_list].to_a : []
      @legendary_actions_header = opts.key?(:legendary_actions_header) ? opts[:legendary_actions_header].strip : ''
      @legendary_actions_count  = opts.key?(:legendary_actions_count) ? opts[:legendary_actions_count].to_i : 0
      @legendary_actions_list   = opts.key?(:legendary_actions_list) ? opts[:legendary_actions_list].to_a : []
      @mythic_actions_header    = opts.key?(:mythic_actions_header) ? opts[:mythic_actions_header].strip : ''
      @mythic_actions_list      = opts.key?(:mythic_actions_list) ? opts[:mythic_actions_list].to_a : []
      @inventory                = opts.key?(:inventory) ? opts[:inventory] : []
      @inventory                = Inventory.new unless @inventory.is_a? Inventory
      @purse                    = opts.key?(:purse) ? opts[:purse] : []
      @purse                    = Purse.new unless @purse.is_a? Purse
      @description              = opts.key?(:description) ? opts[:description].strip : ''
      @environment              = opts.key?(:environment) ? opts[:environment].to_a : []
    end

    # Get the being's name.
    #
    # @return           [String]          The being's name.
    def to_s
      @name
    end

    # Get either the being's Challenge Rating or the sum
    # of its levels.
    #
    # @return           [Integer]         Either the being's CR or the sum of its levels.
    def to_i
      if @levels.nil?
        @cr
      else
        @levels.values.sum
      end
    end

    # Get an Array of the being's abilities in the classical
    # order: Strength, Dexterity, Constitution, Intelligence,
    # Wisdom, and Charisma.
    #
    # @return           [Array]           An Array of the being's abilities: `[STR, DEX, CON, INT, WIS, CHA]`.
    def to_a
      [@str, @dex, @con, @int, @wis, @cha]
    end

    # Get a Hash of the being's abilities, indexed by each
    # ability abbreviation.
    #
    # @return           [Hash]            A Hash of the being's abilities.
    def to_h
      {
        str: @str,
        dex: @dex,
        con: @con,
        int: @int,
        wis: @wis,
        cha: @cha
      }
    end

    # Get the Saving Throw modifier for the given ability.
    #
    # @param  ability   [Symbol,String]   The ability abbreviation as either a String or a Symbol.
    # @raise            [StandardError]   If the given ability is not a valid ability abbreviation.
    # @return           [Integer]         The corresponding save modifier.
    # @see ABILITIES
    def save(ability)
      # Raise error if ability is not valid.
      raise StandardError, 'Invalid ability.' unless ABILITIES.include?(ability.to_sym)

      # Parse ability to valid string
      ability = ability[0..2].downcase.to_swm
      # Check for Proficiency in the Saving Throw
      mod = @saves.include?(ability) ? @proficiency : 0

      case ability
      when :str then modifier(@str) + mod
      when :dex then modifier(@dex) + mod
      when :con then modifier(@con) + mod
      when :int then modifier(@int) + mod
      when :wis then modifier(@wis) + mod
      when :cha then modifier(@cha) + mod
      else
        0
      end
    end

    # Roll for a Saving Throw for the given ability.
    #
    # @param  ability   [Symbol,String]   The ability abbreviation as either a String or a Symbol.
    # @raise            [StandardError]   If the given ability is not a valid ability abbreviation.
    # @return           [Integer]         The roll's result added to the corresponding save modifier.
    # @see ABILITIES
    def roll_for_save(ability)
      mod = save(ability)
      roll = rand(1..20)

      roll + mod
    end

    # Get the Skill modifier for the given skill.
    #
    # The possible skills are:
    #
    # - `:acrobatics`;
    # - `:animal_handling`;
    # - `:arcana`;
    # - `:athletics`;
    # - `:deception`;
    # - `:history`;
    # - `:insight`;
    # - `:intimidation`;
    # - `:investigation`;
    # - `:medicine`;
    # - `:nature`;
    # - `:perception`;
    # - `:performance`;
    # - `:persuasion`;
    # - `:religion`;
    # - `:sleight_hand`;
    # - `:stealth`; and
    # - `:survival`.
    #
    # This method also accepts a String of the **full name**
    # of the skill, as presented in the official character
    # sheet.
    #
    # @param  skill     [Symbol,String]   The skill as either a String or a Symbol.
    # @raise            [StandardError]   If the given skill is not a valid one.
    # @return           [Integer]         The corresponding skill modifier.
    # @see SKILLS
    def skill(skill)
      # Raise error if skill is not valid.
      raise StandardError, 'Invalid skill.' unless SKILLS.include?(skill.to_sym)

      # Parse skill to valid string
      skill.gsub!(' of', '').gsub!(/ /, '_').downcase! unless skill.is_a? Symbol
      # Check for Proficiency or Expertise in the skill
      mod = if @skills.include? skill.to_sym
              @proficiency
            elsif @skills_expertise.include? skill.to_sym
              @proficiency * 2
            else
              0
            end

      case skill.to_sym
      when :athletics
        modifier(@str) + mod
      when :acrobatics, :sleight_hand, :stealth
        modifier(@dex) + mod
      when :arcana, :history, :investigation, :nature, :religion
        modifier(@int) + mod
      when :animal_handling, :insight, :medicine, :perception, :survival
        modifier(@wis) + mod
      when :deception, :intimidation, :performance, :persuasion
        modifier(@cha) + mod
      else
        0
      end
    end

    # Roll for the given Skill.
    #
    # The possible skills are:
    #
    # - `:acrobatics`;
    # - `:animal_handling`;
    # - `:arcana`;
    # - `:athletics`;
    # - `:deception`;
    # - `:history`;
    # - `:insight`;
    # - `:intimidation`;
    # - `:investigation`;
    # - `:medicine`;
    # - `:nature`;
    # - `:perception`;
    # - `:performance`;
    # - `:persuasion`;
    # - `:religion`;
    # - `:sleight_hand`;
    # - `:stealth`; and
    # - `:survival`.
    #
    # This method also accepts a String of the **full name**
    # of the skill, as presented in the official character
    # sheet.
    #
    # @param  skill     [Symbol,String]   The skill as either a String or a Symbol.
    # @raise            [StandardError]   If the given skill is not a valid one.
    # @return           [Integer]         The roll's result added to the corresponding skill modifier, either plain, proficiency, or expertise.
    # @see SKILLS
    def roll_for_skill(skill)
      mod = skill(skill)
      roll = rand(1..20)

      roll + mod
    end

    # Deal some damage to this Being, modifying the current
    # HP accordingly.
    #
    # If the damage is greater than the current HP, the
    # latter is normalized to `0`, instead.
    #
    # @param  amount    [Integer]   The amount of damage to be dealt, negative values are accepted, but are **not** counted as healing --- use {heal} instead.
    # @return           [Integer]   The new current HP.
    def damage(amount)
      amount       = amount.to_i.abs
      @current_hp -= amount
      @current_hp  = [@current_hp, 0].max
      @current_hp
    end

    # Heal this Being by the given amount, modifying the
    # current HP accordingly.
    #
    # If the new current HP is greater than the maximun
    # HP, the former is normalized to the maximun HP,
    # instead.
    #
    # @param  amount    [Integer]   The amount to heal the Being by, negative values are accepted, but are **not** counted as damage --- use {damage} instead.
    # @return           [Integer]   The new current HP.
    def heal(amount)
      amount       = amount.to_i.abs
      @current_hp += amount
      @current_hp  = [@current_hp, @hp].min
      @current_hp
    end

    # Whether this Being is dead or not.
    #
    # Uses the current HP as parameter to define dead
    # status.
    #
    # @return         [Boolean]   `true` if current HP is `0`, `false` otherwise.
    def dead?
      @current_hp.zero?
    end

    # Whether this Being is alive or not.
    #
    # Uses the current HP as parameter to define life
    # status.
    #
    # @return         [Boolean]   `true` if current HP is greater than `0`, `false` otherwise.
    def alive?
      @current_hp.positive?
    end

    private

    # Calculate proficiency bonus according to [Someone_Evil's formula](https://rpg.stackexchange.com/questions/161150/what-is-the-mathematical-formula-for-proficiency-bonus-vs-level-cr).
    #
    # @param  levels  [Integer,Hash]  Either the total level or a Hash of levels.
    # @return         [Integer]       An Integer representing the corresponding Proficiency Bonus.
    def proficiency_bonus(levels)
      total_level = if levels.is_a? Numeric
                      levels.to_i
                    elsif levels.is_a? Hash
                      levels.values.sum
                    else
                      0
                    end
      if total_level.positive?
        (1.0 + (total_level.to_f / 4.0)).ceil
      else
        2
      end
    end

    # Set ability scores randomly
    #
    # @param    opts  [Hash]                    A Hash of options to be used.
    # @option   opts  [Array<Symbol>]   :prefs  An Array of Symbol's representing the order to prioritize abilities.
    # @option   opts  [Integer]         :min    The minimum value an ability can have, defaults to `1`.
    # @option   opts  [Integer]         :max    The minimum value an ability can have, defaults to `20`.
    def roll_for_abilities(**opts)
      # Get minimum value, or set it to `1`.
      min       = opts.key?(:min) ? opts[:min].to_i - 10 : -9
      # Get maximum value, or set it to `20`.
      max       = opts.key?(:max) ? opts[:max].to_i - 10 : 10
      # Set min and max as range
      range     = Range.new min, max

      # Get preferences and parse their uniquiness, or shuffle de default list above.
      prefs = if opts.key? :prefs
                opts[:prefs].to_a.uniq
              else
                ABILITIES.shuffle
              end
      # Filter invalid abilities
      prefs.select! { |x| ABILITIES.include? x }
      # Add randomly any missing abilities, if applicable
      missing_abilities = ABILITIES - prefs
      prefs += missing_abilities.shuffle if missing_abilities.length.positive?

      # Roll scores
      scores = Array.new(6)
      scores.map! do
        10 + rand(range)
      end
      # Order from biggest to lowest
      scores.sort!.reverse!

      # Assign scores to abilities
      prefs.each_with_index do |a, i|
        case a
        when :str then @str = scores[i]
        when :dex then @dex = scores[i]
        when :con then @con = scores[i]
        when :int then @int = scores[i]
        when :wis then @wis = scores[i]
        when :cha then @cha = scores[i]
        end
      end
    end

    # Get the modifier for the given attribute's value.
    #
    # `Modifier = (Score - 10) / 2`, rounded down.
    #
    # @param    value   [Numeric]   A value to have its modifier calculated.
    # @return           [Integer]   The corresponding modifier, according to the formula above.
    def modifier(value)
      ((value.to_f - 10.0) / 2.0).floor
    end
  end
end
