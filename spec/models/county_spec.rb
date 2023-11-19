# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
    describe '#std_fips_code' do
        it 'returns the standardized FIPS code' do
            county = County.new(fips_code: 1)
            expect(county.std_fips_code).to eq('001')
        end

        it 'returns the standardized FIPS code for double-digit numbers' do
            county = County.new(fips_code: 12)
            expect(county.std_fips_code).to eq('012')
        end

        it 'returns the standardized FIPS code for triple-digit numbers' do
            county = County.new(fips_code: 123)
            expect(county.std_fips_code).to eq('123')
        end
    end
end

