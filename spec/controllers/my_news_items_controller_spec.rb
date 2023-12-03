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
end
