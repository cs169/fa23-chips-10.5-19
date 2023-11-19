# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
    describe '.civic_api_to_representative_params' do
        it 'creates representatives from rep_info' do
            rep_info = double('rep_info')
            officials = [
                double('official1', name: 'Oski Bear'),
                double('official2', name: 'Michael Ball')
            ]
            offices = [
                double('office1', name: 'Office 1', division_id: 'ocdid1', official_indices: [0]),
                double('office2', name: 'Office 2', division_id: 'ocdid2', official_indices: [1])
            ]
            allow(rep_info).to receive(:officials).and_return(officials)
            allow(rep_info).to receive(:offices).and_return(offices)

            expect(Representative).to receive(:create!).with({ name: 'Oski Bear', ocdid: 'ocdid1', title: 'Office 1' })
            expect(Representative).to receive(:create!).with({ name: 'Michael Ball', ocdid: 'ocdid2', title: 'Office 2' })

            Representative.civic_api_to_representative_params(rep_info)
        end
    end
end
