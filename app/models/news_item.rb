# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  ISSUES_LIST = ['Free Speech', 'Immigration', 'Terrorism',
                 'Social Security and Medicare', 'Abortion',
                 'Student Loans', 'Gun Control', 'Unemployment',
                 'Climate Change', 'Homelessness', 'Racism',
                 'Tax Reform', 'Net Neutrality', 'Religious Freedom',
                 'Border Security', 'Minimum Wage', 'Equal Pay'].freeze

  validates :issue, presence: true, inclusion: { in: ISSUES_LIST }

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.issues
    ISSUES_LIST
  end
end
