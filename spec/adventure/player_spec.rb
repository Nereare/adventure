# frozen_string_literal: true

RSpec.describe Adventure::Player do
  describe 'Player creation' do
    it 'instantializes a player' do
      expect(described_class.new(
               'Player Name',
               ['wizard'],
               'elf',
               'non-binary'
             )).to be_instance_of(described_class)
    end
  end

  describe 'Player methods' do
    before do
      @player = described_class.new(
        'Player Name',
        ['wizard'],
        'elf',
        'non-binary',
        level: 4,
        purse: Adventure::Purse.new(
          cp: 6,
          sp: 12,
          gp: 8
        )
      )
    end

    it 'returns the player\'s summary' do
      expect(@player.to_s).not_to be_nil
      expect(@player.to_s).to be_a(String)
    end

    it 'returns the player\'s total level' do
      expect(@player.to_i).not_to be_nil
      expect(@player.to_i).to be_an(Integer)
      expect(@player.to_i).to eq(@player.level)
    end

    it 'returns the player\'s name' do
      expect(@player.name).not_to be_nil
      expect(@player.name).to be_a(String)
    end

    it 'returns the player\'s total level as its Integer equivalent' do
      expect(@player.level).not_to be_nil
      expect(@player.level).to be_an(Integer)
    end

    it 'returns the player\'s list of classes' do
      expect(@player.classes).not_to be_nil
      expect(@player.classes).to be_an(Array)
    end

    it 'returns the player\'s species' do
      expect(@player.species).not_to be_nil
      expect(@player.species).to be_a(String)
    end

    it 'returns the player\'s gender' do
      expect(@player.gender).not_to be_nil
      expect(@player.gender).to be_a(String)
    end

    it 'returns the player\'s Purse object' do
      expect(@player.purse).not_to be_nil
      expect(@player.purse).to be_an(Adventure::Purse)
    end

    it 'returns the player\'s Inventory object' do
      expect(@player.inventory).not_to be_nil
      expect(@player.inventory).to be_an(Adventure::Inventory)
    end

    it 'can be leveled up' do
      expect { @player.level_up }.to change { @player.level }.from(4).to(5)
    end

    it 'can have classes added to them' do
      expect { @player.new_class 'cleric' }.to change { @player.level }.from(4).to(5)
    end
  end
end
