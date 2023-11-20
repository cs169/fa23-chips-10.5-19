# frozen_string_literal: true
# require 'rails_helper'

# RSpec.describe NewsItemsController, type: :controller do
#   describe '#index' do
#     it 'assigns @news_items with news items belonging to the representative' do
#       representative = create(:representative)
#       news_item1 = create(:news_item, representative: representative)
#       news_item2 = create(:news_item, representative: representative)

#       get :index, params: { representative_id: representative.id }

#       expect(assigns(:news_items)).to match_array([news_item1, news_item2])
#     end
#   end

#   describe '#show' do
#     it 'assigns @news_item with the specified news item' do
#       news_item = create(:news_item)

#       get :show, params: { id: news_item.id }

#       expect(assigns(:news_item)).to eq(news_item)
#     end
#   end
# end
