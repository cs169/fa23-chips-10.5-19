require 'rails_helper'

RSpec.describe Event, type: :model do
    describe 'validations' do
        
        it 'should validate that start_time is after today' do
            event = Event.new(start_time: Time.zone.now - 1.day)
            expect(event).not_to be_valid
            expect(event.errors[:start_time]).to include('must be after today')
        end
        
        it 'should validate that end_time is after start_time' do
            event = Event.new(start_time: Time.zone.now, end_time: Time.zone.now - 1.day)
            expect(event).not_to be_valid
            expect(event.errors[:end_time]).to include('must be after start time')
        end
    end
    

    
    describe '#county_names_by_id' do
        it 'should return a hash of county names by id' do
            dummyDate = DateTime.new(2001,2,3,4,5,6)
            state = State.create(symbol: 'test_state', symbol: 'test_state', fips_code: 'test_state', is_territory: 'test_state', lat_min: 'test_state', lat_max: 'test_state', long_min: 'test_state', long_max: 'test_state' )
            county1 = County.create(state_id: @state.id, name: 'test_county', fips_code: 'test_county', fips_class: 'test_county', created_at: dummyDate, updated_at: dummyDate)
            county2 = County.create(state_id: @state.id, name: 'test_county2', fips_code: 'test_county2', fips_class: 'test_county2', created_at: dummyDate, updated_at: dummyDate)

            event = Event.create(county: county1)

            expect(event.county_names_by_id).to eq({ 'County 1' => county1.id, 'County 2' => county2.id })
        end

        it 'should return an empty hash if county is nil' do
            event = Event.create(county: nil)

            expect(event.county_names_by_id).to eq({})
        end
    end
end
