# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
    describe 'GET #index' do
        it 'assigns all representatives to @representatives' do
            representative1 = Representative.create(name: 'John Doe')
            representative2 = Representative.create(name: 'Jane Smith')

            get :index

            expect(assigns(:representatives)).to eq([representative1, representative2])
        end

        it 'renders the index template' do
            get :index

            expect(response).to render_template(:index)
        end
    end
end
