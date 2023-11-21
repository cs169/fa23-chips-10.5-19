# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#index' do
    it 'assigns all events when no filter is applied' do
      events = instance_double(Event)
      allow(Event).to receive(:all).and_return(events)

      get :index

      expect(assigns(:events)).to eq(events)
    end

    it 'assigns filtered events when filter-by is state-only' do
      state = instance_double(State)
      counties = instance_double(County)
      events = instance_double(Event)
      allow(State).to receive(:find_by).and_return(state)
      allow(state).to receive(:counties).and_return(counties)
      allow(Event).to receive(:where).with(county: counties).and_return(events)
      get :index, params: { 'filter-by' => 'state-only', 'state' => 'some_state' }
      expect(assigns(:events)).to eq(events)
    end
  end

  describe '#show' do
    it 'assigns the requested event' do
      event = instance_double(Event)
      allow(Event).to receive(:find).and_return(event)

      get :show, params: { id: 1 }

      expect(assigns(:event)).to eq(event)
    end
  end
end
