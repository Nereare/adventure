# frozen_string_literal: true

RSpec.describe Adventure::Challenge do
  describe 'Challenge creation' do
    it 'instantializes a challenge' do
      expect(described_class.new(
               12,
               'Stealth (Dexterity)',
               challenge_text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
               challenge_inline: 'Lorem ipsum dolor sit amet.',
               challenge_button: 'Foo bar.',
               success_text: 'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
               success_inline: 'Class aptent taciti sociosqu ad litora.',
               failure_text: 'Ut iaculis, felis nec faucibus dignissim, metus massa congue felis, dignissim sagittis quam augue non orci.',
               failure_inline: 'Ut iaculis, felis nec faucibus dignissim.'
             )).to be_instance_of(described_class)
    end
  end

  describe 'Challenge methods' do
    before do
      @challenge = described_class.new(
        12,
        'Stealth (Dexterity)',
        challenge_text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        challenge_inline: 'Lorem ipsum dolor sit amet.',
        challenge_button: 'Foo bar.',
        success_text: 'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
        success_inline: 'Class aptent taciti sociosqu ad litora.',
        failure_text: 'Ut iaculis, felis nec faucibus dignissim, metus massa congue felis, dignissim sagittis quam augue non orci.',
        failure_inline: 'Ut iaculis, felis nec faucibus dignissim.'
      )
    end

    it 'returns the challenge\'s name' do
      expect(@challenge.name).not_to be_nil
      expect(@challenge.name).to be_a(String)
    end

    it 'returns the challenge\'s skill' do
      expect(@challenge.skill).not_to be_nil
      expect(@challenge.skill).to be_a(String)
    end

    it 'returns the challenge\'s Difficulty Class' do
      expect(@challenge.dc).not_to be_nil
      expect(@challenge.dc).to be_an(Integer)
      expect(@challenge.dc).to eq(@challenge.to_i)
    end

    it 'returns the challenge\'s text' do
      expect(@challenge.to_s).not_to be_nil
      expect(@challenge.to_s).to be_a(String)
      expect(@challenge.text).to be_a(String)
      expect(@challenge.to_s).to eq(@challenge.text(inline: true))
    end

    it 'returns the challenge\'s button/action text' do
      expect(@challenge.button).not_to be_nil
      expect(@challenge.button).to be_a(String)
    end

    it 'returns that the challenge is unrolled' do
      expect(@challenge.unrolled?).not_to be_nil
      expect(@challenge.unrolled?).to be true
    end

    it 'is rollable' do
      expect(@challenge).to respond_to(:roll)
      expect { @challenge.roll 16 }.to change(@challenge, :success?).from(nil).to(true)
    end
  end
end
