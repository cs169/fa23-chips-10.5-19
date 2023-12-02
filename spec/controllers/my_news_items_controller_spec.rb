# frozen_string_literal: true

RSpec.describe MyNewsItemsController, type: :controller do
  describe '#search_news_items' do
    let(:representative) { Representative.create }
    let(:issue) { 'your_issue' }
    let(:params) do
      { representative_id: representative.id, news_item: { representative_id: representative.id, issue: issue } }
    end

    it 'assigns the representative' do
      post :search_news_items, params: params
      expect(assigns(:representative)).to eq(@representative)
    end

    it 'assigns the selected issue' do
      post :search_news_items, params: params
      expect(assigns(:selected_issue)).to eq(@issue)
    end
  end
end
