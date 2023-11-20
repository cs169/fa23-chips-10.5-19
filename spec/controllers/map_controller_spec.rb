# frozen_string_literal: true
# require 'rails_helper'

# RSpec.describe MapController, type: :controller do
#     describe "GET #index" do
#         it "returns http success" do
#             get :index
#             expect(response).to be_successful
#         end

#         it "assigns @states_by_fips_code" do
#             states = create_list(:state, 3)
#             get :index
#             expect(assigns(:states_by_fips_code)).to eq(states.index_by(&:std_fips_code))
#         end
#     end

#     describe "GET #state" do
#         let(:state) { create(:state) }

#         context "when state exists" do
#             it "assigns @county_details" do
#                 counties = create_list(:county, 3, state: state)
#                 get :state, params: { state_symbol: state.symbol }
#                 expect(assigns(:county_details)).to eq(counties.index_by(&:std_fips_code))
#             end
#         end

#         context "when state does not exist" do
#             it "redirects to root path with an alert" do
#                 get :state, params: { state_symbol: "INVALID" }
#                 expect(response).to redirect_to(root_path)
#                 expect(flash[:alert]).to eq("State 'INVALID' not found.")
#             end
#         end
#     end

#     describe "GET #county" do
#         let(:state) { create(:state) }
#         let(:county) { create(:county, state: state) }

#         context "when state and county exist" do
#             it "assigns @county" do
#                 get :county, params: { state_symbol: state.symbol, std_fips_code: county.std_fips_code }
#                 expect(assigns(:county)).to eq(county)
#             end

#             it "assigns @county_details" do
#                 counties = create_list(:county, 3, state: state)
#                 get :county, params: { state_symbol: state.symbol, std_fips_code: county.std_fips_code }
#                 expect(assigns(:county_details)).to eq(counties.index_by(&:std_fips_code))
#             end
#         end

#         context "when state does not exist" do
#             it "redirects to root path with an alert" do
#                 get :county, params: { state_symbol: "INVALID", std_fips_code: county.std_fips_code }
#                 expect(response).to redirect_to(root_path)
#                 expect(flash[:alert]).to eq("State 'INVALID' not found.")
#             end
#         end

#         context "when county does not exist" do
#             it "redirects to root path with an alert" do
#                 get :county, params: { state_symbol: state.symbol, std_fips_code: 999 }
#                 expect(response).to redirect_to(root_path)
#                 expect(flash[:alert]).to eq("County with code '999' not found for #{state.symbol}")
#             end
#         end
#     end
# end
