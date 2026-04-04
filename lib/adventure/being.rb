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
    # Being's name
    attr_reader :name
    # Being's source text, when applicable
    attr_reader :source
    # Being's alignment
    attr_reader :align
    # Being's Challenge Rating
    attr_reader :cr
    # Being's Proficiency bonus
    attr_reader :proficiency
    # Being's Hash of levels by, when applicable, class, or Integer of total level
    attr_reader :levels
    # Being's size
    attr_reader :size
    # Being's type
    attr_reader :type
    # Whether or not this is a swarm of beings
    attr_reader :swarm
    # Being's Hash of speeds, with five elements representing walk, burrow, climb, fly, and swim speeds -- the ones that don't apply set to `nil`
    attr_reader :speed
    # Being's Array of senses, empty by default
    attr_reader :senses
    # Being's Array of known languages
    attr_reader :languages
    # Being's Strength score
    attr_reader :ability_str
    # Being's Dexterity score
    attr_reader :ability_dex
    # Being's Constitution score
    attr_reader :ability_con
    # Being's Intelligence score
    attr_reader :ability_int
    # Being's Wisdom score
    attr_reader :ability_wis
    # Being's Charisma score
    attr_reader :ability_cha
    # Being's Strength saving throw
    attr_reader :save_str
    # Being's Dexterity saving throw
    attr_reader :save_dex
    # Being's Constitution saving throw
    attr_reader :save_con
    # Being's Intelligence saving throw
    attr_reader :save_int
    # Being's Wisdom saving throw
    attr_reader :save_wis
    # Being's Charisma saving throw
    attr_reader :save_cha
    # Being's Acrobatics skill bonus
    attr_reader :skill_acrobatics
    # Being's Animal Handling skill bonus
    attr_reader :skill_animal_handling
    # Being's Arcana skill bonus
    attr_reader :skill_arcana
    # Being's Athletics skill bonus
    attr_reader :skill_athletics
    # Being's Deception skill bonus
    attr_reader :skill_deception
    # Being's History skill bonus
    attr_reader :skill_history
    # Being's Insight skill bonus
    attr_reader :skill_insight
    # Being's Intimidation skill bonus
    attr_reader :skill_intimidation
    # Being's Investigation skill bonus
    attr_reader :skill_investigation
    # Being's Medicine skill bonus
    attr_reader :skill_medicine
    # Being's Nature skill bonus
    attr_reader :skill_nature
    # Being's Perception skill bonus
    attr_reader :skill_perception
    # Being's Performance skill bonus
    attr_reader :skill_performance
    # Being's Persuasion skill bonus
    attr_reader :skill_persuasion
    # Being's Religion skill bonus
    attr_reader :skill_religion
    # Being's Sleight of Hand skill bonus
    attr_reader :skill_sleight_hand
    # Being's Stealth skill bonus
    attr_reader :skill_stealth
    # Being's Survival skill bonus
    attr_reader :skill_survival
    # Being's Passive Perception score
    attr_reader :passive_perception
    # Being's Armor Class
    attr_reader :ac
    # Being's AC description, if any
    attr_reader :ac_desc
    # Being's total/maximum Hit Points
    attr_reader :hp
    # Being's HP dice formula
    attr_reader :hp_formula
    # Being's Array of Damage Vulnerabilities, if any -- empty by default
    attr_reader :dmg_vulnerabilities
    # Being's Array of Damage Resistances, if any -- empty by default
    attr_reader :dmg_resistances
    # Being's Array of Damage Immunities, if any -- empty by default
    attr_reader :dmg_immunities
    # Being's Array of Condition Immunities, if any -- empty by default
    attr_reader :condition_immunities
    # Being's Spellcasting block header -- `nil` if not applicable
    attr_reader :spell_header
    # Being's Spellcasting block footer -- `nil` if not applicable
    attr_reader :spell_footer
    # Being's Spellcasting array of spells -- empty by default
    attr_reader :spell_list
    # Being's array of traits
    attr_reader :traits
    # Being's Actions' header
    attr_reader :actions_header
    # Being's Array of Actions
    attr_reader :actions_list
    # Being's Bonus Actions' header
    attr_reader :bonus_actions_header
    # Being's Array of Bonus Actions
    attr_reader :bonus_actions_list
    # Being's Reactions' header
    attr_reader :reactions_header
    # Being's Array of Reactions
    attr_reader :reactions_list
    # Being's Legendary Actions' header
    attr_reader :legendary_actions_header
    # Being's number of Legendary Actions, as Integer
    attr_reader :legendary_actions_count
    # Being's Array of Legendary Actions
    attr_reader :legendary_actions_list
    # Being's Mythic Actions' header
    attr_reader :mythic_actions_header
    # Being's Array of Mythic Actions
    attr_reader :mythic_actions_list
    # Being's list of {Item}s
    attr_reader :gear
    # Being's {Purse}
    attr_reader :purse
    # Being's flavor description/informations
    attr_reader :description
    # Being's Array of environments
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
    # @option  opts  [Integer]              :ability_str               Being's Strength score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :ability_dex               Being's Dexterity score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :ability_con               Being's Constitution score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :ability_int               Being's Intelligence score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :ability_wis               Being's Wisdom score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :ability_cha               Being's Charisma score, defaults to `10`, it unset.
    # @option  opts  [Integer]              :save_str                  Being's Strength saving throw.
    # @option  opts  [Integer]              :save_dex                  Being's Dexterity saving throw.
    # @option  opts  [Integer]              :save_con                  Being's Constitution saving throw.
    # @option  opts  [Integer]              :save_int                  Being's Intelligence saving throw.
    # @option  opts  [Integer]              :save_wis                  Being's Wisdom saving throw.
    # @option  opts  [Integer]              :save_cha                  Being's Charisma saving throw.
    # @option  opts  [Integer]              :skill_acrobatics          Being's Acrobatics skill bonus.
    # @option  opts  [Integer]              :skill_animal_handling     Being's Animal Handling skill bonus.
    # @option  opts  [Integer]              :skill_arcana              Being's Arcana skill bonus.
    # @option  opts  [Integer]              :skill_athletics           Being's Athletics skill bonus.
    # @option  opts  [Integer]              :skill_deception           Being's Deception skill bonus.
    # @option  opts  [Integer]              :skill_history             Being's History skill bonus.
    # @option  opts  [Integer]              :skill_insight             Being's Insight skill bonus.
    # @option  opts  [Integer]              :skill_intimidation        Being's Intimidation skill bonus.
    # @option  opts  [Integer]              :skill_investigation       Being's Investigation skill bonus.
    # @option  opts  [Integer]              :skill_medicine            Being's Medicine skill bonus.
    # @option  opts  [Integer]              :skill_nature              Being's Nature skill bonus.
    # @option  opts  [Integer]              :skill_perception          Being's Perception skill bonus.
    # @option  opts  [Integer]              :skill_performance         Being's Performance skill bonus.
    # @option  opts  [Integer]              :skill_persuasion          Being's Persuasion skill bonus.
    # @option  opts  [Integer]              :skill_religion            Being's Religion skill bonus.
    # @option  opts  [Integer]              :skill_sleight_hand        Being's Sleight of Hand skill bonus.
    # @option  opts  [Integer]              :skill_stealth             Being's Stealth skill bonus.
    # @option  opts  [Integer]              :skill_survival            Being's Survival skill bonus.
    # @option  opts  [Integer]              :passive_perception        Being's Passive Perception score.
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
    # @option  opts  [Array]                :gear                      Being's list of {Item}s.
    # @option  opts  [Purse]                :purse                     Being's {Purse}.
    # @option  opts  [String]               :description               Being's flavor description/informations.
    # @option  opts  [Array]                :environment               Being's Array of environments.
    def initialize(name, **opts)
      @name                     = name.strip
      @source                   = opts.key?(:source) ? opts[:source].strip : nil
      @align                    = opts.key?(:align) ? opts[:align].strip : nil
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
      @size                     = opts.key?(:size) ? opts[:size].strip : nil
      @type                     = opts.key?(:type) ? opts[:type].strip : nil
      @swarm                    = opts.key?(:swarm) ? !opts[:swarm].nil? : nil
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
      @languages                = opts.key?(:languages) ? opts[:languages].to_a : []
      if opts.key? :rand_abilities
        prefs                   = opts.key?(:ability_preferences) ? opts[:ability_preferences].to_a : nil
        min                     = opts.key?(:ability_min) ? opts[:ability_min].to_i : 1
        max                     = opts.key?(:ability_max) ? opts[:ability_max].to_i : 20
        roll_for_abilities(prefs: prefs, min: min, max: max)
      else
        @ability_str            = opts.key?(:ability_str) ? opts[:ability_str].to_i : 10
        @ability_dex            = opts.key?(:ability_dex) ? opts[:ability_dex].to_i : 10
        @ability_con            = opts.key?(:ability_con) ? opts[:ability_con].to_i : 10
        @ability_int            = opts.key?(:ability_int) ? opts[:ability_int].to_i : 10
        @ability_wis            = opts.key?(:ability_wis) ? opts[:ability_wis].to_i : 10
        @ability_cha            = opts.key?(:ability_cha) ? opts[:ability_cha].to_i : 10
      end
      # TODO: Fix saving throw calculating - change :save_... from integer to boolean and using PB + ... modifier
      @save_str                 = opts.key?(:save_str) ? opts[:save_str].to_i : 0
      @save_dex                 = opts.key?(:save_dex) ? opts[:save_dex].to_i : 0
      @save_con                 = opts.key?(:save_con) ? opts[:save_con].to_i : 0
      @save_int                 = opts.key?(:save_int) ? opts[:save_int].to_i : 0
      @save_wis                 = opts.key?(:save_wis) ? opts[:save_wis].to_i : 0
      @save_cha                 = opts.key?(:save_cha) ? opts[:save_cha].to_i : 0
      @skill_acrobatics         = opts.key?(:skill_acrobatics) ? opts[:skill_acrobatics].to_i : 0
      @skill_animal_handling    = opts.key?(:skill_animal_handling) ? opts[:skill_animal_handling].to_i : 0
      @skill_arcana             = opts.key?(:skill_arcana) ? opts[:skill_arcana].to_i : 0
      @skill_athletics          = opts.key?(:skill_athletics) ? opts[:skill_athletics].to_i : 0
      @skill_deception          = opts.key?(:skill_deception) ? opts[:skill_deception].to_i : 0
      @skill_history            = opts.key?(:skill_history) ? opts[:skill_history].to_i : 0
      @skill_insight            = opts.key?(:skill_insight) ? opts[:skill_insight].to_i : 0
      @skill_intimidation       = opts.key?(:skill_intimidation) ? opts[:skill_intimidation].to_i : 0
      @skill_investigation      = opts.key?(:skill_investigation) ? opts[:skill_investigation].to_i : 0
      @skill_medicine           = opts.key?(:skill_medicine) ? opts[:skill_medicine].to_i : 0
      @skill_nature             = opts.key?(:skill_nature) ? opts[:skill_nature].to_i : 0
      @skill_perception         = opts.key?(:skill_perception) ? opts[:skill_perception].to_i : 0
      @skill_performance        = opts.key?(:skill_performance) ? opts[:skill_performance].to_i : 0
      @skill_persuasion         = opts.key?(:skill_persuasion) ? opts[:skill_persuasion].to_i : 0
      @skill_religion           = opts.key?(:skill_religion) ? opts[:skill_religion].to_i : 0
      @skill_sleight_hand       = opts.key?(:skill_sleight_hand) ? opts[:skill_sleight_hand].to_i : 0
      @skill_stealth            = opts.key?(:skill_stealth) ? opts[:skill_stealth].to_i : 0
      @skill_survival           = opts.key?(:skill_survival) ? opts[:skill_survival].to_i : 0
      @passive_perception       = opts.key?(:passive_perception) ? opts[:passive_perception].to_i : 0
      @ac                       = opts.key?(:ac) ? opts[:ac].to_i : 0
      @ac_desc                  = opts.key?(:ac_desc) ? opts[:ac_desc].strip : nil
      @hp                       = opts.key?(:hp) ? opts[:hp].to_i : 0
      @hp_formula               = opts.key?(:hp_formula) ? opts[:hp_formula].strip : nil
      @dmg_vulnerabilities      = opts.key?(:dmg_vulnerabilities) ? opts[:dmg_vulnerabilities].to_a : []
      @dmg_resistances          = opts.key?(:dmg_resistances) ? opts[:dmg_resistances].to_a : []
      @dmg_immunities           = opts.key?(:dmg_immunities) ? opts[:dmg_immunities].to_a : []
      @condition_immunities     = opts.key?(:condition_immunities) ? opts[:condition_immunities].to_a : []
      @spell_header             = opts.key?(:spell_header) ? opts[:spell_header].strip : nil
      @spell_footer             = opts.key?(:spell_footer) ? opts[:spell_footer].strip : nil
      @spell_list               = opts.key?(:spell_list) ? opts[:spell_list].to_a : []
      @traits                   = opts.key?(:traits) ? opts[:traits].to_a : []
      @actions_header           = opts.key?(:actions_header) ? opts[:actions_header].strip : nil
      @actions_list             = opts.key?(:actions_list) ? opts[:actions_list].to_a : []
      @bonus_actions_header     = opts.key?(:bonus_actions_header) ? opts[:bonus_actions_header].strip : nil
      @bonus_actions_list       = opts.key?(:bonus_actions_list) ? opts[:bonus_actions_list].to_a : []
      @reactions_header         = opts.key?(:reactions_header) ? opts[:reactions_header].strip : nil
      @reactions_list           = opts.key?(:reactions_list) ? opts[:reactions_list].to_a : []
      @legendary_actions_header = opts.key?(:legendary_actions_header) ? opts[:legendary_actions_header].strip : nil
      @legendary_actions_count  = opts.key?(:legendary_actions_count) ? opts[:legendary_actions_count].to_i : 0
      @legendary_actions_list   = opts.key?(:legendary_actions_list) ? opts[:legendary_actions_list].to_a : []
      @mythic_actions_header    = opts.key?(:mythic_actions_header) ? opts[:mythic_actions_header].strip : nil
      @mythic_actions_list      = opts.key?(:mythic_actions_list) ? opts[:mythic_actions_list].to_a : []
      @gear                     = opts.key?(:gear) ? opts[:gear].to_a : []
      @purse                    = opts.key?(:purse) ? opts[:purse] : Purse.new
      @description              = opts.key?(:description) ? opts[:description].strip : nil
      @environment              = opts.key?(:environment) ? opts[:environment].to_a : []
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
      # Set filler with all valid abilities.
      abilities = %i[str dex con int wis cha]
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
                abilities.shuffle
              end
      # Filter invalid abilities
      prefs.select! { |x| abilities.include? x }
      # Add randomly any missing abilities, if applicable
      missing_abilities = abilities - prefs
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
        when :str then @ability_str = scores[i]
        when :dex then @ability_dex = scores[i]
        when :con then @ability_con = scores[i]
        when :int then @ability_int = scores[i]
        when :wis then @ability_wis = scores[i]
        when :cha then @ability_cha = scores[i]
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
