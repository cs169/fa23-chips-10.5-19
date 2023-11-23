# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe SessionController, type: :controller do
#     describe '#require_login!' do
#         context 'when session[:current_user_id] is present' do
#             it 'sets session[:destination_after_login] and redirects to login_url' do
#                 user = User.create
#                 session[:current_user_id] = user.id
#                 request.env['REQUEST_URI'] = '/some/path'

#                 get :require_login!

#                 expect(session[:destination_after_login]).to eq('/some/path')
#                 expect(response).to redirect_to(login_url)
#             end
#         end

#         context 'when session[:current_user_id] is not present' do
#             it 'sets session[:destination_after_login] and redirects to login_url' do
#                 request.env['REQUEST_URI'] = '/some/path'

#                 get :require_login!

#                 expect(session[:destination_after_login]).to eq('/some/path')
#                 expect(response).to redirect_to(login_url)
#             end
#         end
#     end
# end
