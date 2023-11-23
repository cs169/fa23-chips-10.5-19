# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    it 'returns the full name of the user' do
      user = described_class.new(first_name: 'Oski', last_name: 'Bear')
      expect(user.name).to eq('Oski Bear')
    end
  end

  describe '#auth_provider' do
    it 'returns the correct authentication provider name' do
      user = described_class.new(provider: :google_oauth2)
      expect(user.auth_provider).to eq('Google')

      user = described_class.new(provider: :github)
      expect(user.auth_provider).to eq('Github')
    end
  end

  describe '.find_google_user' do
    it 'finds a user with the given uid and google_oauth2 provider' do
      user = described_class.create(provider: :google_oauth2, uid: '123')
      found_user = described_class.find_google_user('123')
      expect(found_user).to eq(user)
    end
  end

  describe '.find_github_user' do
    it 'finds a user with the given uid and github provider' do
      user = described_class.create(provider: :github, uid: '456')
      found_user = described_class.find_github_user('456')
      expect(found_user).to eq(user)
    end
  end
end
