# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    it 'returns a JSON response with counties' do
      state = State.create(
        name:         'New York',
        symbol:       'NY',
        fips_code:    1,
        is_territory: 0,
        lat_min:      40.496,
        lat_max:      45.015,
        long_min:     -79.762,
        long_max:     -71.856
      )
      county1 = County.create(
        name:       'County 1',
        state:      state,
        fips_code:  123,
        fips_class: 'A',
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
      county2 = County.create(
        name:       'County 2',
        state:      state,
        fips_code:  456,
        fips_class: 'B',
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
      expect(state).not_to be_nil
      expect(county1).not_to be_nil
      expect(county2).not_to be_nil
      get :counties, params: { state_symbol: 'NY' }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json')

      counties = JSON.parse(response.body)
      expect(counties.length).to eq(2)
      expect(counties[0]['name']).to eq('County 1')
      expect(counties[1]['name']).to eq('County 2')
    end
  end
end
