# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe NewsItemsController, type: :controller do
#   describe 'GET #index' do
#     before do
#       # Create test data before triggering the action
#       @representative = Representative.create(name: 'John Doe')  # Adjust attributes as needed
#       @news_item1 = NewsItem.create(title: 'News Item 1', link: 'https://example.com/news1', representative: @representative)
#       @news_item2 = NewsItem.create(title: 'News Item 2', link: 'https://example.com/news2', representative: @representative)
#       # Ensure the representative is signed in if you have authentication
#       # sign_in @representative
#     end

#     it 'assigns @news_items' do
#       get :index, params: { representative_id: @representative.id }
#       expect(assigns(:news_items)).to eq([@news_item1, @news_item2])
#     end
#   end
# end
