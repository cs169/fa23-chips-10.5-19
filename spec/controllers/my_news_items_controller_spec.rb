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

    describe '#news_api_request' do
      it 'returns articles when the response code is 200' do
        query = 'example query'
        articles = [
          { 'title' => 'Article 1' },
          { 'title' => 'Article 2' }
        ]
        response_body = { 'articles' => articles }.to_json
        response = double('response', code: '200', body: response_body)
        allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)

        result = described_class.new.send(:news_api_request, query)
        expect(result).to eq(articles)
      end

      it 'returns nil when the response code is not 200' do
        query = 'example query'
        response = double('response', code: '404', message: 'Not Found')
        allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)

        result = described_class.new.send(:news_api_request, query)

        expect(result).to be_nil
      end
    end
  end

  describe '#save_article' do
    let(:representative) { Representative.create! }
    let(:article_data) do
      {
        'title'       => 'Test Title',
        'url'         => 'http://example.com',
        'description' => 'Test Description',
        'publishedAt' => '2023-01-01T00:00:00Z'
      }
    end
    let(:params) do
      {
        selected_article: article_data.to_json,
        news_item:        { rating: 5, issue: 'Test Issue' }
      }
    end

    it 'saves a new news item from an article' do
      expect do
        post "/representatives/#{representative.id}/my_news_item/save_article", params: params
      end.to change(NewsItem, :count).by(1)
      expect(response).to redirect_to representative_news_items_path(representative)
    end
  end
end
