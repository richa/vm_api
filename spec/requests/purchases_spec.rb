require 'rails_helper'

RSpec.describe "Purchases", type: :request do
  let!(:user)   { FactoryBot.create(:buyer, deposit: 200) }
  let!(:auth_token)   { FactoryBot.create(:auth_token, user: user) }
  let!(:product)   { FactoryBot.create(:product, cost: 50, amount_available: 3) }
  let!(:product2)   { FactoryBot.create(:product, cost: 200, amount_available: 3) }

  let(:headers) {{ 'Authorization': "Bearer #{auth_token.token}" }}
  let(:params) {{ product_id: product.id, quantity: 2 }}

  describe "POST /buy" do
    it "creates purchase and returns user balance" do
      old_purchase_count = Purchase.count
      post '/api/v1/buy', params: params, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(res['user_balance']['total']).to eq(100)
      expect(res['product']['amount_available']).to eq(1)
      expect(Purchase.count).to eq(old_purchase_count+1)
    end

    it "returns error if user has insufficient balance" do
      post '/api/v1/buy', params: { product_id: product2.id, quantity: 2 }, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(res['errors']['user']).to eq(['Insufficient balance.'])
    end

    it "returns error if product quantity is not available" do
      post '/api/v1/buy', params: { product_id: product.id, quantity: 4 }, headers: headers

      res = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(res['errors']['product']).to eq(['Insufficient products in stock.'])
    end

    it "returns error if user is not logged in" do
      post '/api/v1/buy', params: params, headers: {}

      res = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(res['errors']['base']).to eq('Unauthorized')
    end
  end
end
