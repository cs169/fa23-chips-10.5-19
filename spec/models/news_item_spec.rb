# frozen_string_literal: true

# # frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  # let(:issues_list) do
  #   ['Free Speech', 'Immigration', 'Terrorism',
  #    'Social Security and Medicare', 'Abortion',
  #    'Student Loans', 'Gun Control', 'Unemployment',
  #    'Climate Change', 'Homelessness', 'Racism',
  #    'Tax Reform', 'Net Neutrality', 'Religious Freedom',
  #    'Border Security', 'Minimum Wage', 'Equal Pay']
  # end

  # it 'has a valid list of issues' do
  #   expect(NewsItem::ISSUES_LIST).to match_array(issues_list)
  # end

  it 'validates presence of issue' do
    news_article = described_class.new(issue: nil)
    expect(news_article).not_to be_valid
    expect(news_article.errors[:issue]).to include("can't be blank")
  end

  it 'validates incorrect issues' do
    news_article = described_class.new(issue: 'hamburger')
    expect(news_article).not_to be_valid
    expect(news_article.errors[:issue]).to include('is not included in the list')
  end

  it 'validates correct issues' do
    rep1 = Representative.create(name: 'John Doe')
    news_article = described_class.new(issue: 'Free Speech', representative: rep1)
    expect(NewsItem::ISSUES_LIST).to include('Free Speech')
    expect(news_article).to be_valid
  end
end
