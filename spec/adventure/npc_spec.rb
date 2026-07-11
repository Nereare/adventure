# frozen_string_literal: true

RSpec.describe Adventure::NPC do
  describe 'Metadata checks' do
    it 'has a list of friendship levels' do
      expect(Adventure::NPC::FriendshipLevel).to be_a(Module)
    end
  end

  describe 'NPC creation' do
    it 'instantializes a minimal NPC' do
      expect(described_class.new(
               'Test Name',
               'Test Species',
               'Test Gender'
             )).to be_instance_of(described_class)
    end

    it 'instantializes an NPC with dialogues' do
      expect(described_class.new(
               'Test Name',
               'Test Species',
               'Test Gender',
               dialogue: [
                 {
                   question: 'Lorem ipsum',
                   answer: 'Dolor sit amet.'
                 },
                 {
                   question: 'Vestibulum sagittis',
                   answer: 'Sem vitae felis egestas, non facilisis ex.'
                 }
               ]
             )).to be_instance_of(described_class)
    end
  end

  describe 'NPC methods' do
    before do
      @npc = described_class.new(
        'Test Name',
        'Test Species',
        'Test Gender',
        dialogue: [
          {
            question: 'Lorem ipsum',
            answer: 'Dolor sit amet.'
          },
          {
            question: 'Vestibulum sagittis',
            answer: 'Sem vitae felis egestas, non facilisis ex.'
          }
        ]
      )
    end

    it 'has an introductory tagline' do
      expect(@npc.to_s).not_to be_nil
      expect(@npc.to_s).to be_a(String)
    end

    it 'has a name' do
      expect(@npc.name).not_to be_nil
      expect(@npc.name).to be_a(String)
    end

    it 'has a species' do
      expect(@npc.species).not_to be_nil
      expect(@npc.species).to be_a(String)
    end

    it 'has a gender' do
      expect(@npc.gender).not_to be_nil
      expect(@npc.gender).to be_a(String)
    end

    it 'has a friendship' do
      expect(@npc.friendship).not_to be_nil
      expect(@npc.friendship).to be_an(Integer)
    end

    it 'has a friendship as its integer equivalent' do
      expect(@npc.to_i).not_to be_nil
      expect(@npc.to_i).to be_an(Integer)
    end

    it 'has a friendship equal to its integer equivalent' do
      expect(@npc.friendship).to eq(@npc.to_i)
    end

    it 'has a purse' do
      expect(@npc.purse).not_to be_nil
      expect(@npc.purse).to be_an(Adventure::Purse)
    end

    it 'has a inventory' do
      expect(@npc.inventory).not_to be_nil
      expect(@npc.inventory).to be_an(Adventure::Inventory)
    end

    it 'has a dialogue' do
      expect(@npc.dialogue).not_to be_nil
      expect(@npc.dialogue).to be_an(Array)
    end

    it 'can have its friendship improved' do
      expect(@npc).to respond_to(:charm)
      expect { @npc.charm }.to change(@npc, :friendship).from(3).to(4)
    end

    it 'can have its friendship harmed' do
      expect(@npc).to respond_to(:offend)
      expect { @npc.offend }.to change(@npc, :friendship).from(3).to(2)
    end
  end
end
