# frozen_string_literal: true

RSpec.describe Adventure::Item do
  describe 'Metadata checks' do
    it 'has a list of item types' do
      expect(Adventure::Item::Type).to be_a(Module)
    end

    it 'has a list of damage types' do
      expect(Adventure::Item::DamageType).to be_a(Module)
    end

    it 'has a list of rarities' do
      expect(Adventure::Item::Rarity).to be_a(Module)
    end

    it 'has a list of possible properties' do
      expect(Adventure::Item::Property).to be_a(Module)
    end
  end

  describe 'Item creation' do
    it 'instantializes a minimal item' do
      expect(described_class.new('Test', 'Test item description.', Adventure::Item::Type::TOOL)).to be_instance_of(described_class)
    end

    it 'instantializes an item with price and weight' do
      expect(described_class.new('Test 2', 'Test item 2 description.', Adventure::Item::Type::TOOL, price: 10.0, weight: 1.0)).to be_instance_of(described_class)
    end
  end

  describe 'Item global methods' do
    before do
      @item3 = described_class.new(
        'Test 3',
        'Test item 3 description.',
        Adventure::Item::Type::TOOL,
        price: 5.0,
        weight: 1.0
      )
    end

    it 'has a name' do
      expect(@item3.to_s).not_to be_nil
      expect(@item3.to_s).to be_a(String)
    end

    it 'has a description' do
      expect(@item3.description).not_to be_nil
      expect(@item3.description).to be_a(String)
    end

    it 'has an item type' do
      expect(@item3.type).not_to be_nil
    end

    it 'has a price/value' do
      expect(@item3.price).not_to be_nil
      expect(@item3.price).to be_a(Float)
    end

    it 'has a weight' do
      expect(@item3.weight).not_to be_nil
      expect(@item3.weight).to be_a(Float)
    end
  end

  describe 'Weapon item methods' do
    before do
      @weapon = described_class.new(
        'Test Weapon',
        'Test weapon description.',
        Adventure::Item::Type::WEAPON_MELEE,
        price: 25.5,
        weight: 12.0,
        dmg_notation: '1d8+2',
        dmg_type: Adventure::Item::DamageType::BLUDGEONING
      )
    end

    it 'returns true when checked if weapon' do
      expect(@weapon).to be_weapon
    end

    it 'has a damage specification' do
      expect(@weapon.damage_notation).not_to be_nil
      expect(@weapon.damage_notation).to match(/\d+d\d+([+-]\d)?/)
    end

    it 'rolls for damage' do
      expect(@weapon.damage).not_to be_nil
      expect(@weapon.damage).to be_a(Integer)
    end
  end

  describe 'Armor item methods' do
    before do
      @armor = described_class.new(
        'Test Armor',
        'Test armor description.',
        Adventure::Item::Type::ARMOR_LIGHT,
        price: 81.0,
        weight: 30.0,
        ac: 12
      )
    end

    it 'returns true when checked if armor' do
      expect(@armor).to be_armor
    end

    it 'has an Armor Class (AC)' do
      expect(@armor.ac(4)).not_to be_nil
      expect(@armor.ac(4)).to be_a(Integer)
    end
  end

  describe 'Magic item methods' do
    before do
      @magic_item = described_class.new(
        'Magic Item',
        'Magic item description.',
        Adventure::Item::Type::WONDROUS,
        price: 3_800.0,
        weight: 0.5,
        magic: true,
        rarity: Adventure::Item::Rarity::RARE,
        attunement: true
      )
    end

    it 'returns true when checked if magic' do
      expect(@magic_item).to be_magic
    end

    it 'has a rarity' do
      expect(@magic_item.rarity).not_to be_nil
      expect(@magic_item.rarity).to be_a(String)
    end

    it 'either requires attunement as a text, or doesn\'t as an empty String' do
      expect(@magic_item.attunement).not_to be_nil
      expect(@magic_item.attunement).to be_a(String)
    end
  end
end
