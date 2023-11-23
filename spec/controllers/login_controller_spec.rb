# frozen_string_literal: true

require 'rails_helper'
RSpec.describe LoginController, type: :controller do
  describe '#login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe '#logout' do
    it 'clears the current_user_id session variable' do
      session[:current_user_id] = 1
      get :logout
      expect(session[:current_user_id]).to be_nil
    end

    it 'redirects to the root path' do
      get :logout
      expect(response).to redirect_to(root_path)
    end

    it 'sets the notice flash message' do
      get :logout
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end
end
