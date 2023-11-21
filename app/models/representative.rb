# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      political_party_temp = official.party || ''
      photo_temp = official.photoUrl || ''

      if official.addresses.present?
        address = official.address.first
        street_temp = address.line1
        city_temp = address.city
        state_temp = address.state
        zip_temp = address.zip
      else
        street_temp = ''
        city_temp = ''
        state_temp = ''
        zip_temp = ''
      end

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!({ name: official.name, 
        ocdid: ocdid_temp,
        title: title_temp,
        street: street_temp,
        city: city_temp,
        state: state_temp,
        zip: zip_temp,
        party: political_party_temp,
        photo: photo_temp})
      reps.push(rep)
    end

    reps
  end
end
