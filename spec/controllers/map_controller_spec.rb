# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe '#index' do
    it 'assigns @states_by_fips_code' do
      # Use a verifying double for State
      states = [instance_double(State, std_fips_code: '01'), instance_double(State, std_fips_code: '02')]
      allow(State).to receive(:all).and_return(states)

      get :index

      expect(assigns(:states_by_fips_code)).to eq(states.index_by(&:std_fips_code))
    end
  end

  describe '#state' do
    context 'when state is not found' do
      before do
        allow(State).to receive(:find_by).and_return(nil)
      end

      it 'redirects to root path with alert message' do
        get :county, params: { state_symbol: 'NY', std_fips_code: '001' }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'NY' not found.")
      end
    end
  end
end
