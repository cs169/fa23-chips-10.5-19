RSpec.describe MyNewsItemsController do
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

          result = MyNewsItemsController.new.send(:news_api_request, query)
          expect(result).to eq(articles)
      end
      it 'returns nil when the response code is not 200' do
          query = 'example query'
          response = double('response', code: '404', message: 'Not Found')
          allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)
    
          result = MyNewsItemsController.new.send(:news_api_request, query)
    
          expect(result).to be_nil
        end
  end


end