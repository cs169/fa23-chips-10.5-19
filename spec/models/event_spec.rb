require 'rails_helper'

RSpec.describe Event, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:start_time) }
        it { should validate_presence_of(:end_time) }
        
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
    
    describe 'associations' do
        it { should belong_to(:county) }
        it { should delegate_method(:state).to(:county).allow_nil }
    end
    
    describe '#county_names_by_id' do
        it 'should return a hash of county names by id' do
            state = FactoryBot.create(:state)
            county1 = FactoryBot.create(:county, state: state, name: 'County 1')
            county2 = FactoryBot.create(:county, state: state, name: 'County 2')
            event = FactoryBot.create(:event, county: county1)
            
            expect(event.county_names_by_id).to eq({ 'County 1' => county1.id, 'County 2' => county2.id })
        end
        
        it 'should return an empty hash if county is nil' do
            event = FactoryBot.create(:event, county: nil)
            
            expect(event.county_names_by_id).to eq({})
        end
    end
end
