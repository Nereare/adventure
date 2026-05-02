# frozen_string_literal: true

RSpec.describe Adventure::Room do
  describe 'Room creation' do
    it 'instantializes a minimal room' do
      expect(described_class.new('Test Room', 'Test room description.')).to be_instance_of(described_class)
    end

    it 'instantializes a minimal dark room' do
      expect(described_class.new('Test Room 2', 'Test room 2 description.', lit: false)).to be_instance_of(described_class)
    end

    it 'instantializes a room with exits' do
      expect(described_class.new(
               'Test Room 3',
               'Test room 3 description.',
               exits: {
                 north: described_class.new('North Exit', 'North exit description'),
                 east: described_class.new('East Exit', 'East exit description.')
               }
             )).to be_instance_of(described_class)
    end
  end

  describe 'Room methods' do
    before do
      @room = described_class.new(
        'Complex Test Room',
        'Complex test room description.',
        lit: true,
        exits: {
          north: 2,
          east: :east_room
        },
        contents: Adventure::Inventory.new(
          Adventure::Item.new('Item 1', 'Item 1 description.', Adventure::Item::Type::TOOL),
          Adventure::Item.new('Item 2', 'Item 2 description.', Adventure::Item::Type::TOOL)
        )
      )
    end

    it 'returns the room\'s name' do
      expect(@room.to_s).not_to be_nil
      expect(@room.to_s).to be_a(String)
      expect(@room.name).not_to be_nil
      expect(@room.name).to be_a(String)
    end

    it 'returns the room\'s description' do
      expect(@room.description).not_to be_nil
      expect(@room.description).to be_a(String)
    end

    it 'returns the room\'s contents as a string' do
      expect(@room.contents).not_to be_nil
      expect(@room.contents).to be_a(String)
    end

    it 'returns the room\'s contents as an Inventory object' do
      expect(@room.inventory).not_to be_nil
      expect(@room.inventory).to be_an(Adventure::Inventory)
    end

    it 'returns the room\'s specific exit' do
      expect(@room.exit(:north)).not_to be_nil
      expect(@room.exit(:north)).to be_an(Integer)
      expect(@room.east).not_to be_nil
      expect(@room.east).to be_a(Symbol)
    end

    it 'returns a list of the room\'s exits' do
      expect(@room.exits).not_to be_nil
      expect(@room.exits).to be_a(Hash)
      expect(@room.exits.values).to all(be_an(Integer).or(be_a(Symbol)))
    end
  end
end
