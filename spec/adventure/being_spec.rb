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

    #
  end
end
