require 'rails_helper'

RSpec.describe LoginController, type: :controller do
    describe '#login' do
        it 'renders the login template' do
            get :login
            expect(response).to render_template(:login)
        end
    end

    describe '#google_oauth2' do
        it 'calls create_session with :create_google_user' do
            expect(controller).to receive(:create_session).with(:create_google_user)
            get :google_oauth2
        end
    end

    describe '#github' do
        it 'calls create_session with :create_github_user' do
            expect(controller).to receive(:create_session).with(:create_github_user)
            get :github
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

    describe '#create_session' do
        it 'finds or creates a user' do
            user_info = { 'provider' => 'google_oauth2', 'uid' => '123' }
            expect(controller).to receive(:find_or_create_user).with(user_info, :create_google_user)
            controller.send(:create_session, :create_google_user)
        end

        it 'sets the current_user_id session variable' do
            user = double('User', id: 1)
            allow(controller).to receive(:find_or_create_user).and_return(user)
            controller.send(:create_session, :create_google_user)
            expect(session[:current_user_id]).to eq(1)
        end

        it 'redirects to the destination URL' do
            user = double('User', id: 1)
            allow(controller).to receive(:find_or_create_user).and_return(user)
            session[:destination_after_login] = '/dashboard'
            controller.send(:create_session, :create_google_user)
            expect(response).to redirect_to('/dashboard')
        end

        it 'clears the destination_after_login session variable' do
            user = double('User', id: 1)
            allow(controller).to receive(:find_or_create_user).and_return(user)
            session[:destination_after_login] = '/dashboard'
            controller.send(:create_session, :create_google_user)
            expect(session[:destination_after_login]).to be_nil
        end
    end

    describe '#find_or_create_user' do
        it 'finds the user if it exists' do
            user_info = { 'provider' => 'google_oauth2', 'uid' => '123' }
            user = double('User')
            expect(User).to receive(:find_by).with(provider: User.providers[:google_oauth2], uid: '123').and_return(user)
            expect(controller.send(:find_or_create_user, user_info, :create_google_user)).to eq(user)
        end

        it 'calls the create_if_not_exists method if the user does not exist' do
            user_info = { 'provider' => 'google_oauth2', 'uid' => '123' }
            expect(controller).to receive(:create_google_user).with(user_info)
            controller.send(:find_or_create_user, user_info, :create_google_user)
        end
    end

    describe '#create_google_user' do
        it 'creates a user with the correct attributes' do
            user_info = {
                'uid' => '123',
                'provider' => 'google_oauth2',
                'info' => {
                    'first_name' => 'John',
                    'last_name' => 'Doe',
                    'email' => 'john.doe@example.com'
                }
            }
            expect(User).to receive(:create).with(
                uid: '123',
                provider: User.providers[:google_oauth2],
                first_name: 'John',
                last_name: 'Doe',
                email: 'john.doe@example.com'
            )
            controller.send(:create_google_user, user_info)
        end
    end

    describe '#create_github_user' do
        it 'creates a user with the correct attributes' do
            user_info = {
                'uid' => '123',
                'provider' => 'github',
                'info' => {
                    'name' => 'John Doe',
                    'email' => 'john.doe@example.com'
                }
            }
            expect(User).to receive(:create).with(
                uid: '123',
                provider: User.providers[:github],
                first_name: 'John',
                last_name: 'Doe',
                email: 'john.doe@example.com'
            )
            controller.send(:create_github_user, user_info)
        end

        it 'creates a user with default first_name and last_name if name is nil' do
            user_info = {
                'uid' => '123',
                'provider' => 'github',
                'info' => {
                    'name' => nil,
                    'email' => 'john.doe@example.com'
                }
            }
            expect(User).to receive(:create).with(
                uid: '123',
                provider: User.providers[:github],
                first_name: 'Anon',
                last_name: 'User',
                email: 'john.doe@example.com'
            )
            controller.send(:create_github_user, user_info)
        end
    end

    describe '#already_logged_in' do
        it 'redirects to the user profile path if the current_user_id session variable is present' do
            session[:current_user_id] = 1
            get :already_logged_in
            expect(response).to redirect_to(user_profile_path)
        end

        it 'does not redirect if the current_user_id session variable is not present' do
            get :already_logged_in
            expect(response).not_to redirect_to(user_profile_path)
        end
    end
end
