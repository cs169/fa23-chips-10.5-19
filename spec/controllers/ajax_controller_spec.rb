# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe AjaxController, type: :controller do
#     describe 'GET #counties' do
#         let(:state) { State.create(:state) } # Assuming you have a factory for creating states

#         it 'returns a JSON response with the counties' do
#             get :counties, params: { state_symbol: state.symbol }

#             expect(response).to have_http_status(:success)
#             expect(response.content_type).to eq('application/json')

#             counties = JSON.parse(response.body)
#             expect(counties).to eq(state.counties)
#         end

#         it 'returns a not found response if state is not found' do
#             get :counties, params: { state_symbol: 'invalid_state' }

#             expect(response).to have_http_status(:not_found)
#         end
#     end
# end
