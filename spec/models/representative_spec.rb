# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe '#civic_api_to_representative_params' do
    before do
      @existing_rep = described_class.create(name: 'Existing Representative', ocdid: 'existing_ocdid',
                                             title: 'Existing Title', street: '123 playground',
                                             city: 'Berkeley', state: 'CA', zip: '94704',
                                             political_party: 'Democrat', photo: 'aaaaa')
    end

    it 'does not create a duplicate representative' do
      address_double = double('address',
                              line1: '123 playground', city: 'Berkeley',
                              state: 'CA', zip: '94704')

      rep_info = double('rep_info',
                        officials: [
                          double('official', name: 'Existing Representative', party: 'Democrat',
                          photoUrl: 'aaaaa', address: [address_double])
                        ],
                        offices:   [
                          double('office', name: 'Existing Title', division_id: 'existing_ocdid', official_indices: [0])
                        ])

      allow(described_class).to receive(:create!).with(hash_including(name: 'Existing Representative',
                                                                      ocdid: 'existing_ocdid', title: 'Existing Title',
                                                                      street: '123 playground', city: 'Berkeley',
                                                                      state: 'CA', zip: '94704',
                                                                      political_party: 'Democrat',
                                                                      photo: 'aaaaa')).and_return(['new rep'])

      reps = described_class.civic_api_to_representative_params(rep_info)

      expect(described_class).to have_received(:create!).exactly(0).times
      expect(reps).to eq([@existing_rep])
    end
  end
end
