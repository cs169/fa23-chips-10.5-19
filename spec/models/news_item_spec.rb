# frozen_string_literal: true
# # frozen_string_literal: true
# # # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe NewsItem, type: :model do
#   describe 'class methods' do
#     describe '.find_for' do
#       let(:representative) { double('Representative', id: 1) } # Using a double for Representative
#       let!(:news_item) { double('NewsItem') } # Using a double for NewsItem

#       before do
#         allow(NewsItem).to receive(:create).and_return(news_item)
#         allow(news_item).to receive(:representative).and_return(representative)
#       end

#       it 'returns the news item for the given representative id' do
#         found_news_item = described_class.find_for(representative.id)
#         expect(found_news_item).to eq(news_item)
#       end
#     end
#   end
# end
