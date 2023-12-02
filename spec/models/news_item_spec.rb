# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
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
