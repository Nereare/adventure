# frozen_string_literal: true

RSpec.describe Adventure do
  it 'has a version number' do
    expect(Adventure::VERSION).not_to be_nil
  end
end
