require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
    describe 'GET #new' do
        it 'assigns a new event to @event' do
            get :new
            expect(assigns(:event)).to be_a_new(Event)
        end

        it 'renders the new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            let(:valid_params) do
                {
                    event: {
                        name: 'Test Event',
                        county_id: 1,
                        description: 'Test description',
                        start_time: Time.now,
                        end_time: Time.now + 1.hour
                    }
                }
            end

            it 'creates a new event' do
                expect {
                    post :create, params: valid_params
                }.to change(Event, :count).by(1)
            end

            it 'redirects to the events index page' do
                post :create, params: valid_params
                expect(response).to redirect_to(events_path)
            end

            it 'sets a success notice' do
                post :create, params: valid_params
                expect(flash[:notice]).to eq('Event was successfully created.')
            end
        end

        context 'with invalid parameters' do
            let(:invalid_params) do
                {
                    event: {
                        name: '',
                        county_id: 1,
                        description: 'Test description',
                        start_time: Time.now,
                        end_time: Time.now + 1.hour
                    }
                }
            end

            it 'does not create a new event' do
                expect {
                    post :create, params: invalid_params
                }.not_to change(Event, :count)
            end

            it 'renders the new template' do
                post :create, params: invalid_params
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'GET #edit' do
        let(:event) { Event.create(name: 'Test Event') }

        it 'renders the edit template' do
            get :edit, params: { id: event.id }
            expect(response).to render_template(:edit)
        end
    end

    describe 'PATCH #update' do
        let(:event) { Event.create(name: 'Test Event') }

        context 'with valid parameters' do
            let(:valid_params) do
                {
                    id: event.id,
                    event: {
                        name: 'Updated Event'
                    }
                }
            end

            it 'updates the event' do
                patch :update, params: valid_params
                event.reload
                expect(event.name).to eq('Updated Event')
            end

            it 'redirects to the events index page' do
                patch :update, params: valid_params
                expect(response).to redirect_to(events_path)
            end

            it 'sets a success notice' do
                patch :update, params: valid_params
                expect(flash[:notice]).to eq('Event was successfully updated.')
            end
        end

        context 'with invalid parameters' do
            let(:invalid_params) do
                {
                    id: event.id,
                    event: {
                        name: ''
                    }
                }
            end

            it 'does not update the event' do
                patch :update, params: invalid_params
                event.reload
                expect(event.name).to eq('Test Event')
            end

            it 'renders the edit template' do
                patch :update, params: invalid_params
                expect(response).to render_template(:edit)
            end
        end
    end

    describe 'DELETE #destroy' do
        let!(:event) { Event.create(name: 'Test Event') }

        it 'destroys the event' do
            expect {
                delete :destroy, params: { id: event.id }
            }.to change(Event, :count).by(-1)
        end

        it 'redirects to the events index page' do
            delete :destroy, params: { id: event.id }
            expect(response).to redirect_to(events_path)
        end

        it 'sets a success notice' do
            delete :destroy, params: { id: event.id }
            expect(flash[:notice]).to eq('Event was successfully destroyed.')
        end
    end
end
