# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      # may need to search by more attributes
      existing_rep = Representative.find_or_initialize_by(
        name:  official.name,
        ocdid: ocdid_temp,
        title: title_temp
      )
      unless existing_rep.persisted?
        existing_rep.attributes = create_representative(official, ocdid_temp, title_temp)
        existing_rep.save!
      end
      reps.push(existing_rep)
    end
    reps
  end

  def self.create_representative(official, ocdid_temp, title_temp)
    address = address_hash(official)
    { name:            official.name,
      ocdid:           ocdid_temp,
      title:           title_temp,
      street:          address[0],
      city:            address[1],
      state:           address[2],
      zip:             address[3],
      political_party: official.party || '',
      photo:           official.photo_url || '' }
  end

  def self.address_hash(official)
    if official.address.present?
      address = official.address.first
      [address.line1, address.city, address.state, address.zip]
    else
      ['', '', '', '']
    end
  end
end
