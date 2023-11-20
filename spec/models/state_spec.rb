# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  describe '#std_fips_code' do
    it 'returns the standardized FIPS code' do
      state = described_class.new(fips_code: 6)
      expect(state.std_fips_code).to eq('06')
    end

    it 'returns the standardized FIPS code for single-digit codes' do
      state = described_class.new(fips_code: 9)
      expect(state.std_fips_code).to eq('09')
    end

    it 'returns the standardized FIPS code for three-digit codes' do
      state = described_class.new(fips_code: 123)
      expect(state.std_fips_code).to eq('123')
    end
  end
end
