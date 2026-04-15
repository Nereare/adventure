# frozen_string_literal: true

RSpec.describe Adventure::Inventory do
  describe 'Metadata checks' do
    it 'implements Enumerable' do
      expect(subject).to be_an(Enumerable)
    end

    it 'sets the kilogram per STR point carry weight ratio constant' do
      expect(Adventure::Inventory::KG_PER_STR).not_to be_nil
      expect(Adventure::Inventory::KG_PER_STR).to be_a(Float)
    end

    it 'sets the kilogram per STR point drag weight ratio constant' do
      expect(Adventure::Inventory::DRAG_KG_PER_STR).not_to be_nil
      expect(Adventure::Inventory::DRAG_KG_PER_STR).to be_a(Float)
    end

    it 'has a list of carry/drag weight modifiers for sizes' do
      expect(Adventure::Inventory::SIZE_MODIFIER).not_to be_nil
      expect(Adventure::Inventory::SIZE_MODIFIER).to be_a(Hash)
    end

    it 'has a list of valid sizes' do
      expect(Adventure::Inventory::SIZES).not_to be_nil
      expect(Adventure::Inventory::SIZES).to be_an(Array)
    end
  end

  describe 'Inventory creation' do
    before(:example) do
      @inventory = Adventure::Inventory.new(
        Adventure::Item.new('Item 1', 'Item 1 desc.', Adventure::Item::Type::TOOL),
        Adventure::Item.new('Item 2', 'Item 2 desc.', Adventure::Item::Type::TOOL),
        str: 14
      )
    end

    it 'instantializes an inventory' do
      expect(@inventory).to be
    end
  end

  describe 'Inventory methods' do
    before(:example) do
      @inventory = Adventure::Inventory.new(
        Adventure::Item.new('Item 1', 'Item 1 desc.', Adventure::Item::Type::TOOL),
        Adventure::Item.new('Item 2', 'Item 2 desc.', Adventure::Item::Type::TOOL),
        str: 14,
        size: 'large'
      )
    end

    it 'has a carrying capacity weight limit' do
      expect(@inventory.carrying_capacity).not_to be_nil
      expect(@inventory.carrying_capacity).to be_a(Float)
    end

    it 'has a drag weight limit' do
      expect(@inventory.drag_weight).not_to be_nil
      expect(@inventory.drag_weight).to be_a(Float)
    end

    it 'can iterate through its items' do
      expect(@inventory).to respond_to(:each)
    end

    it 'lists its contents as a String' do
      expect(@inventory.to_s).not_to be_nil
      expect(@inventory.to_s).to be_a(String)
    end

    it 'lists its contents as an Array of its Item\'s names' do
      expect(@inventory.to_a).not_to be_nil
      expect(@inventory.to_a).to be_an(Array)
    end

    it 'lists its contents as a joined Array of its Item\'s names, joined by a given String' do
      expect(@inventory.join).not_to be_nil
      expect(@inventory.join).to be_a(String)
    end

    it 'lists the number of carried items' do
      expect(@inventory.to_i).not_to be_nil
      expect(@inventory.to_i).to be_an(Integer)
    end

    it 'returns the total carried weight' do
      expect(@inventory.carried_weight).not_to be_nil
      expect(@inventory.carried_weight).to be_a(Float)
      expect(@inventory.to_f).not_to be_nil
      expect(@inventory.to_f).to be_a(Float)
    end

    it 'returns whether or not its owner is encumbered' do
      expect(@inventory.encumbered?).not_to be_nil
      expect(@inventory.encumbered?).to be_truthy.or be_falsy
    end

    it 'returns whether or not its owner can only drag it' do
      expect(@inventory.dragging?).not_to be_nil
      expect(@inventory.dragging?).to be_truthy.or be_falsy
    end

    it 'returns a searched item or `nil` if none' do
      expect(@inventory).to respond_to(:get)
      expect(@inventory.get('2')).to be_an(Adventure::Item)
      expect(@inventory.get('3')).to be_nil
    end

    it 'accepts new items' do
      new_item = Adventure::Item.new('New Item', 'New item desc.', Adventure::Item::Type::TOOL)

      expect(@inventory).to respond_to(:add)

      old_count = @inventory.to_i
      @inventory.add(new_item)
      expect(old_count).to be < @inventory.to_i
    end

    it 'removes old items' do
      expect(@inventory).to respond_to(:remove)

      old_count = @inventory.to_i
      @inventory.remove('2')
      expect(old_count).to be > @inventory.to_i
    end
  end
end
