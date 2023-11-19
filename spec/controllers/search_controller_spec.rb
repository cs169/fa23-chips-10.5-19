require 'rails_helper'
require 'google/apis/civicinfo_v2'

RSpec.describe SearchController, type: :controller do
    describe '#search' do
        let(:address) { '123 Main St' }
        let(:service) { instance_double(Google::Apis::CivicinfoV2::CivicInfoService) }
        let(:result) { double('result') }
        let(:representatives) { double('representatives') }

        before do
            allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(service)
            allow(service).to receive(:key=)
            allow(service).to receive(:representative_info_by_address).and_return(result)
            allow(Representative).to receive(:civic_api_to_representative_params).with(result).and_return(representatives)
        end

        it 'assigns @representatives with the result of the Civic API call' do
            get :search, params: { address: address }
            expect(assigns(:representatives)).to eq(representatives)
        end

        it 'renders the search view template' do
            get :search, params: { address: address }
            expect(response).to render_template('representatives/search')
        end
    end
end
