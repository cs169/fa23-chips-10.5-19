# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    describe 'GET #index' do
        context 'when filter-by param is not present' do
            it 'assigns all events to @events' do
                get :index
                expect(assigns(:events)).to eq(Event.all)
            end
        end

        context 'when filter-by param is' do
            it 'calls filter_events and assigns the result to @events' do
                allow(controller).to receive(:filter_events).and_return(Event.where(county: 'test_county'))
                get :index, params: { 'filter-by' => 'state-only' }
                expect(assigns(:events)).to eq(Event.where(county: 'test_county'))
            end
        end
    end

    describe 'GET #show' do
        it 'calls Event.find with the correct id' do
            event = Event.create
            get :show, params: { id: event.id }
            expect(assigns(:event)).to eq(Event.find(event.id))
        end
    end

    # create_table "states", force: :cascade do |t|
    #     t.string "name", null: false
    #     t.string "symbol", null: false
    #     t.integer "fips_code", limit: 1, null: false
    #     t.integer "is_territory", null: false
    #     t.float "lat_min", null: false
    #     t.float "lat_max", null: false
    #     t.float "long_min", null: false
    #     t.float "long_max", null: false
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    # #   end
    # create_table "counties", force: :cascade do |t|
    #     t.string "name", null: false
    #     t.integer "state_id", null: false
    #     t.integer "fips_code", limit: 2, null: false
    #     t.string "fips_class", limit: 2, null: false
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    #     t.index ["state_id"], name: "index_counties_on_state_id"
    #   end
    
    
    describe '#filter_events' do
        before do
            dummyDate = DateTime.new(2001,2,3,4,5,6)
            @state = State.create(symbol: 'test_state', symbol: 'test_state', fips_code: 'test_state', is_territory: 'test_state', lat_min: 'test_state', lat_max: 'test_state', long_min: 'test_state', long_max: 'test_state' )
            @county = County.create(state_id: @state.id, name: 'test_county', fips_code: 'test_county', fips_class: 'test_county', created_at: dummyDate, updated_at: dummyDate)
        end

        context 'when filter-by param is "state-only"' do
            it 'calls Event.where with the correct arguments' do
                allow(controller).to receive(:params).and_return({ 'filter-by' => 'state-only', 'state' => 'test_state' })
                expect(Event).to receive(:where).with(county: @state.counties)
                controller.send(:filter_events)
            end
        end

        context 'when filter-by param is not "state-only"' do
            it 'calls County.find_by and Event.where with the correct arguments' do
                allow(controller).to receive(:params).and_return({ 'filter-by' => 'other', 'state' => 'test_state', 'county' => 'test_county' })
                expect(County).to receive(:find_by).with(state_id: @state.id, fips_code: 'test_county').and_return(@county)
                expect(Event).to receive(:where).with(county: @county)
                controller.send(:filter_events)
            end
        end
    end
end
