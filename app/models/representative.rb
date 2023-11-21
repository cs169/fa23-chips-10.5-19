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

      existing_rep = Representative.find_or_initialize_by(
        name: official.name,
        ocdid: ocdid_temp,
        title: title_temp
      )

      # Add or update additional attributes
      additional_attributes = {
        street: official.address&.first&.line1,
        city: official.address&.first&.city,
        state: official.address&.first&.state,
        zip: official.address&.first&.zip,
        party: official.party,
        photo_url: official.photoUrl
      }

      unless existing_rep.persisted?
        existing_rep.attributes = additional_attributes
        existing_rep.save!
      else
        # Update attributes if the representative already exists
        existing_rep.update(additional_attributes)
      end

      reps.push(existing_rep)
    end
    reps
  end
end
