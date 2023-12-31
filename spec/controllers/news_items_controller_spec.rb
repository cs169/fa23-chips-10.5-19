# frozen_string_literal: true

# # frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  describe 'GET #index' do
    before do
      @representative = Representative.create(name: 'John Doe')
      @news_item1 = NewsItem.create(title: 'News Item 1', representative: @representative,
                                    link: 'https://example.com/news1', issue: 'Free Speech')
      @news_item2 = NewsItem.create(title: 'News Item 2', representative: @representative,
                                    link: 'https://example.com/news2', issue: 'Immigration')
    end

    it 'assigns all news items for the representative to @news_items' do
      get :index, params: { representative_id: @representative.id }
      expect(assigns(:news_items)).to eq([@news_item1, @news_item2])
    end
  end
end
