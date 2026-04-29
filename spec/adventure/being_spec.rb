# frozen_string_literal: true

RSpec.describe Adventure::Being do
  describe 'Metadata checks' do
    it 'has a list of valid abilities' do
      expect(described_class::ABILITIES).to be_an(Array)
      expect(described_class::ABILITIES).to all(be_a(Symbol))
    end

    it 'has a list of valid skills' do
      expect(described_class::SKILLS).to be_an(Array)
      expect(described_class::SKILLS).to all(be_a(Symbol))
    end

    it 'has a list of valid sizes' do
      expect(described_class::SIZES).to be_an(Array)
      expect(described_class::SIZES).to all(be_a(String))
    end

    it 'has a list of valid creature types' do
      expect(described_class::TYPES).to be_an(Array)
      expect(described_class::TYPES).to all(be_a(String))
    end
  end

  describe 'Being creation' do
    it 'instantializes a minimal being' do
      expect(described_class.new('Test Creature')).to be_instance_of(described_class)
    end

    it 'instantializes a complex being' do
      expect(described_class.new(
        'Long Test Creature',
        cr: 18,
        size: 'Large',
        type: 'Humanoid',
        speed: {
                  walk: 45,
                  burrow: 0,
                  climb: 0,
                  fly: 60,
                  swim: 30
                },
        senses: ['truesight'],
        rand_abilities: true,
        ability_min: 18,
        ability_max: 30,
        saves: %i[con int wis cha],
        skills: %i[arcana history investigation insight stealth],
        skills_expertise: %i[arcana history insight],
        ac: 26,
        ac_desc: 'natural armor',
        hp: 140,
        hp_formula: '18d8+60',
        description: 'Long test creature description.'
      )).to be_instance_of(described_class)
    end
  end

  describe 'Being methods' do
    before do
      @being = described_class.new(
        'Long Test Creature',
        cr: 18,
        size: 'Large',
        type: 'Humanoid',
        speed: {
                  walk: 45,
                  burrow: 0,
                  climb: 0,
                  fly: 60,
                  swim: 30
                },
        senses: ['truesight'],
        rand_abilities: true,
        ability_min: 18,
        ability_max: 30,
        saves: %i[con int wis cha],
        skills: %i[arcana history investigation insight stealth],
        skills_expertise: %i[arcana history insight],
        ac: 26,
        ac_desc: 'natural armor',
        hp: 140,
        hp_formula: '18d8+60',
        description: 'Long test creature description.'
      )
    end

    it 'returns the being\'s name' do
      expect(@being.to_s).not_to be_nil
      expect(@being.to_s).to be_a(String)
      expect(@being.name).not_to be_nil
      expect(@being.name).to be_a(String)
    end

    it 'accepts the source request - even if returning `nil`' do
      expect(@being).to respond_to(:source)
      expect(@being.source).to be_a(String).or be_nil
    end

    it 'returns the being\'s alignment' do
      expect(@being.align).not_to be_nil
      expect(@being.align).to be_a(String)
    end

    it 'returns either the being\'s CR or its levels' do
      rep = @being.cr || @being.levels
      expect(rep).not_to be_nil
      expect(rep).to be_a(Hash).or be_a(Numeric)
    end

    it 'returns the being\'s proficiency bonus' do
      expect(@being.proficiency).not_to be_nil
      expect(@being.proficiency).to be_an(Integer)
    end

    it 'returns the being\'s size' do
      expect(@being.size).not_to be_nil
      expect(@being.size).to be_a(String)
    end

    it 'returns the being\'s type' do
      expect(@being.type).not_to be_nil
      expect(@being.type).to be_a(String)
    end

    it 'returns the being\'s subtype' do
      expect(@being.subtype).not_to be_nil
      expect(@being.subtype).to be_a(String)
    end

    it 'returns whether the being\'s a swarm' do
      expect(@being.swarm).not_to be_nil
      expect(@being.swarm).to be(true).or be(false)
    end

    it 'returns the being\'s speeds' do
      expect(@being.speed).not_to be_nil
      expect(@being.speed).to be_a(Hash)
      expect(@being.speed.values).to all(be_a(Numeric))
    end

    it 'returns the being\'s Strength score' do
      expect(@being.str).not_to be_nil
      expect(@being.str).to be_an(Integer)
    end

    it 'returns the being\'s Dexterity score' do
      expect(@being.dex).not_to be_nil
      expect(@being.dex).to be_an(Integer)
    end

    it 'returns the being\'s Constitution score' do
      expect(@being.con).not_to be_nil
      expect(@being.con).to be_an(Integer)
    end

    it 'returns the being\'s Intelligence score' do
      expect(@being.int).not_to be_nil
      expect(@being.int).to be_an(Integer)
    end

    it 'returns the being\'s Wisdom score' do
      expect(@being.wis).not_to be_nil
      expect(@being.wis).to be_an(Integer)
    end

    it 'returns the being\'s Charisma score' do
      expect(@being.cha).not_to be_nil
      expect(@being.cha).to be_an(Integer)
    end

    it 'returns the being\'s spoken languages' do
      expect(@being.languages).not_to be_nil
      expect(@being.languages).to be_an(Array)
      expect(@being.languages).to all(be_a(String))
    end

    it 'returns the being\'s skill modifiers' do
      expect(@being.skill(:stealth)).not_to be_nil
      expect(@being.skill(:stealth)).to be_an(Integer)
    end

    it 'returns the being\'s roll for skill' do
      expect(@being.roll_for_skill(:arcana)).not_to be_nil
      expect(@being.roll_for_skill(:arcana)).to be_an(Integer)
    end

    it 'refuses invalid skills' do
      expect { @being.skill(:foo) }.to raise_error(StandardError)
    end

    it 'returns the being\'s Armor Class' do
      expect(@being.ac).not_to be_nil
      expect(@being.ac).to be_an(Integer)
    end

    it 'returns the being\'s AC description' do
      expect(@being.ac_desc).not_to be_nil
      expect(@being.ac_desc).to be_a(String)
    end

    it 'returns the being\'s maximum Health Points' do
      expect(@being.hp).not_to be_nil
      expect(@being.hp).to be_an(Integer)
    end

    it 'returns the being\'s current HP' do
      expect(@being.current_hp).not_to be_nil
      expect(@being.current_hp).to be_an(Integer)
    end

    it 'returns the being\'s HP formula - i.e. its Hit Die notation' do
      expect(@being.hp_formula).not_to be_nil
      expect(@being.hp_formula).to be_a(String)
    end

    it 'returns the Being\'s Damage Vulnerabilities' do
      expect(@being.dmg_vulnerabilities).not_to be_nil
      expect(@being.dmg_vulnerabilities).to be_an(Array)
    end

    it 'returns the Being\'s Damage Resistances' do
      expect(@being.dmg_resistances).not_to be_nil
      expect(@being.dmg_resistances).to be_an(Array)
    end

    it 'returns the Being\'s Damage Immunities' do
      expect(@being.dmg_immunities).not_to be_nil
      expect(@being.dmg_immunities).to be_an(Array)
    end

    it 'returns the Being\'s Condition Immunities' do
      expect(@being.condition_immunities).not_to be_nil
      expect(@being.condition_immunities).to be_an(Array)
    end

    it 'returns the Being\'s Spellcasting block header' do
      expect(@being.spell_header).not_to be_nil
      expect(@being.spell_header).to be_a(String)
    end

    it 'returns the Being\'s Spellcasting block footer' do
      expect(@being.spell_footer).not_to be_nil
      expect(@being.spell_footer).to be_a(String)
    end

    it 'returns the Being\'s Spellcasting array of spells' do
      expect(@being.spell_list).not_to be_nil
      expect(@being.spell_list).to be_an(Array)
    end

    it 'returns the Being\'s Array of Traits' do
      expect(@being.traits).not_to be_nil
      expect(@being.traits).to be_an(Array)
    end

    it 'returns the Being\'s Actions\' header' do
      expect(@being.actions_header).not_to be_nil
      expect(@being.actions_header).to be_a(String)
    end

    it 'returns the Being\'s Array of Actions' do
      expect(@being.actions_list).not_to be_nil
      expect(@being.actions_list).to be_an(Array)
    end

    it 'returns the Being\'s Bonus Actions\' header' do
      expect(@being.bonus_actions_header).not_to be_nil
      expect(@being.bonus_actions_header).to be_a(String)
    end

    it 'returns the Being\'s Array of Bonus Actions' do
      expect(@being.bonus_actions_list).not_to be_nil
      expect(@being.bonus_actions_list).to be_an(Array)
    end

    it 'returns the Being\'s Reactions\' header' do
      expect(@being.reactions_header).not_to be_nil
      expect(@being.reactions_header).to be_a(String)
    end

    it 'returns the Being\'s Array of Reactions' do
      expect(@being.reactions_list).not_to be_nil
      expect(@being.reactions_list).to be_an(Array)
    end

    it 'returns the Being\'s Legendary Actions\' header' do
      expect(@being.legendary_actions_header).not_to be_nil
      expect(@being.legendary_actions_header).to be_a(String)
    end

    it 'returns the Being\'s number of Legendary Actions, as Integer' do
      expect(@being.legendary_actions_count).not_to be_nil
      expect(@being.legendary_actions_count).to be_an(Integer)
    end

    it 'returns the Being\'s Array of Legendary Actions' do
      expect(@being.legendary_actions_list).not_to be_nil
      expect(@being.legendary_actions_list).to be_an(Array)
    end

    it 'returns the Being\'s Mythic Actions\' header' do
      expect(@being.mythic_actions_header).not_to be_nil
      expect(@being.mythic_actions_header).to be_a(String)
    end

    it 'returns the Being\'s Array of Mythic Actions' do
      expect(@being.mythic_actions_list).not_to be_nil
      expect(@being.mythic_actions_list).to be_an(Array)
    end

    it 'returns the Being\'s list of `Item`s' do
      expect(@being.inventory).not_to be_nil
      expect(@being.inventory).to be_an(Adventure::Inventory)
    end

    it 'returns the Being\'s `Purse`' do
      expect(@being.purse).not_to be_nil
      expect(@being.purse).to be_an(Adventure::Purse)
    end

    it 'returns the Being\'s flavor description/informations' do
      expect(@being.description).not_to be_nil
      expect(@being.description).to be_a(String)
    end

    it 'returns the Being\'s Array of environments' do
      expect(@being.environment).not_to be_nil
      expect(@being.environment).to be_an(Array)
    end

    it 'can take damage' do
      expect(@being).to respond_to(:damage)
    end

    it 'loses HP when taking damage' do
      expect { @being.damage(10) }.to change { @being.current_hp }.from(140).to(130)
    end

    it 'can be healed' do
      expect(@being).to respond_to(:heal)
    end

    it 'regains HP when being healed' do
      @being.damage(10) # Remove 10hp first
      expect { @being.heal(10) }.to change { @being.current_hp }.from(130).to(140)
    end

    it 'returns whether the Being is alive' do
      expect(@being.alive?).not_to be_nil
      expect(@being.alive?).to be(true).or be(false)
    end

    it 'returns whether the Being is dead' do
      expect(@being.dead?).not_to be_nil
      expect(@being.dead?).to be(true).or be(false)
    end
  end
end
