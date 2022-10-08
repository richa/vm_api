require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let!(:user)   { FactoryBot.create(:buyer, deposit: 100) }
  let!(:auth_token)   { FactoryBot.create(:auth_token, user: user) }
  let(:headers) {{ 'Authorization': "Bearer #{auth_token.token}" }}
  let(:params) {{ amount: 50 }}

  describe "PATCH /deposit" do
    it "increments buyer's deposit" do
      patch '/api/v1/deposit', params: params, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(res['balance']['total']).to eq(150)
    end

    it "returns error if user is not logged in" do
      patch '/api/v1/deposit', params: params, headers: {}

      res = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(res['errors']['base']).to eq('Unauthorized')
    end
  end

  describe "DELETE /reset" do
    it "resets buyer's deposit" do
      delete '/api/v1/reset', headers: headers

      res = JSON.parse(response.body)
      expect(response).to have_http_status(200)

      user.reload
      expect(user.deposit).to eq(0)
    end

    it "returns error if user is not logged in" do
      delete '/api/v1/reset', headers: {}

      res = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(res['errors']['base']).to eq('Unauthorized')
    end
  end
end
