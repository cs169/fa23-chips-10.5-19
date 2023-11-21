# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe AjaxController, type: :controller do
#   describe 'GET #counties' do
#     it 'returns a JSON response with counties' do
#       get :counties, params: { state_symbol: 'NY' }

#       expect(response).to have_http_status(:success)
#       expect(response.content_type).to eq('application/json')

#       counties = JSON.parse(response.body)
#       expect(counties.length).to eq(2)
#       expect(counties[0]['name']).to eq('County 1')
#       expect(counties[1]['name']).to eq('County 2')
#     end
#   end
# end
