# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe '#profile' do
    it 'assigns the current user to @user' do
      user = User.create(uid: '123', provider: User.providers[:google_oauth2])
      session[:current_user_id] = user.id

      get :profile

      expect(assigns(:user)).to eq(user)
    end

    it 'renders the profile template' do
      user = User.create(uid: '123', provider: User.providers[:google_oauth2])
      session[:current_user_id] = user.id

      get :profile

      expect(response).to render_template(:profile)
    end

    it 'redirects to the login page if the user is not logged in' do
      get :profile

      expect(response).to redirect_to(login_path)
    end
  end
end
