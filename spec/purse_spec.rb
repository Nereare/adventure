# frozen_string_literal: true

RSpec.describe Adventure::Purse do
  describe 'Purse class methods' do
    it 'parses a GP equivalent total into its coin equivalents' do
      expect(Adventure::Purse).to respond_to(:parse_total)
      expect(Adventure::Purse.parse_total(123.12)).to be_a(Hash)
    end

    it 'parses a Hash of coin counts into its GP equivalent total' do
      expect(Adventure::Purse).to respond_to(:parse_coins)
      expect(Adventure::Purse.parse_coins(cp: 12, gp: 3)).to be_a(Float)
    end
  end

  describe 'Purse creation' do
    it 'instantializes a minimal (empty) purse' do
      expect(Adventure::Purse.new).to be
    end

    it 'instantializes a purse with a GP equivalent' do
      expect(Adventure::Purse.new(total: 12.25)).to be
    end

    it 'instantializes a purse with a list of coins' do
      expect(Adventure::Purse.new(cp: 5, sp: 50, pp: 6)).to be
    end
  end

  describe 'Purse methods' do
    before(:example) do
      @purse = Adventure::Purse.new(
        cp: 5,
        sp: 50,
        pp: 6
      )
    end

    it 'returns the GP equivalent total' do
      expect(@purse.gp_equivalent).not_to be_nil
      expect(@purse.gp_equivalent).to be_a(Float)
      expect(@purse.to_f).not_to be_nil
      expect(@purse.to_f).to be_a(Float)
    end

    it 'returns a list of coins\' totals, as a String' do
      expect(@purse.to_s).not_to be_nil
      expect(@purse.to_s).to be_a(String)
    end

    it 'returns a list of coins\' totals, as an Array' do
      expect(@purse.to_a).not_to be_nil
      expect(@purse.to_a).to be_an(Array)
    end

    it 'returns a list of coins\' totals, as a Hash' do
      expect(@purse.to_h).not_to be_nil
      expect(@purse.to_h).to be_a(Hash)
    end

    it 'is chargeable for values' do
      expect(@purse).to respond_to(:charge)
    end

    it 'is chargeable for values, as a total GP equivalent' do
      expect{ @purse.charge(0.5) }.not_to raise_error
    end

    it 'is chargeable for values, as a list of coins' do
      expect{ @purse.charge({cp: 80}) }.not_to raise_error
    end

    it 'is **not** chargeable for values, as other types' do
      expect{ @purse.charge('cp: 80') }.to raise_error(StandardError)
      expect{ @purse.charge([80, 0, 0, 0]) }.to raise_error(StandardError)
    end

    it 'is open to receive values' do
      expect(@purse).to respond_to(:receive)
    end

    it 'is open to receive values, as a total GP equivalent' do
      expect{ @purse.receive(0.5) }.not_to raise_error
    end

    it 'is open to receive values, as a list of coins' do
      expect{ @purse.receive({cp: 80}) }.not_to raise_error
    end

    it 'is **not** open to receive values, as other types' do
      expect{ @purse.receive('cp: 80') }.to raise_error(StandardError)
      expect{ @purse.receive([80, 0, 0, 0]) }.to raise_error(StandardError)
    end
  end
end
