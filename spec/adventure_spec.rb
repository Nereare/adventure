# frozen_string_literal: true

RSpec.describe Adventure do
  it 'has a name' do
    expect(Adventure::NAME).not_to be_nil
  end

  it 'has a slug' do
    expect(Adventure::SLUG).not_to be_nil
  end

  it 'has a description' do
    expect(Adventure::DESCRIPTION).not_to be_nil
  end

  it 'has a version' do
    expect(Adventure::VERSION).not_to be_nil
  end

  it 'has an author' do
    expect(Adventure::AUTHOR).not_to be_nil
  end

  it 'has an author email' do
    expect(Adventure::AUTHOR_EMAIL).not_to be_nil
  end

  it 'has a author website' do
    expect(Adventure::AUTHOR_URI).not_to be_nil
  end

  it 'has a license' do
    expect(Adventure::LICENSE).not_to be_nil
  end

  it 'has a copyright year' do
    expect(Adventure::YEAR).not_to be_nil
  end
end
