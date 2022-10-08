require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:user)   { FactoryBot.create(:seller) }
  let!(:auth_token)   { FactoryBot.create(:auth_token, user: user) }
  let!(:product)   { FactoryBot.create(:product, cost: 50, amount_available: 3, seller: user) }
  let!(:other_product)   { FactoryBot.create(:product, cost: 100, amount_available: 3) }

  let(:headers) {{ 'Authorization': "Bearer #{auth_token.token}" }}

  describe "POST /products" do
    it "creates product" do
      post '/api/v1/products', params: {
        product: { name: 'Test product 1', cost: 20, amount_available: 5 }
      }, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(Product.last.name).to eq('Test product 1')
    end

    it "returns error if product is not valid" do
      post '/api/v1/products', params: {
        product: { name: '', cost: 20, amount_available: 5 }
      }, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(res['errors']['name']).to eq(["can't be blank"])
    end

    it "returns error if user is not logged in" do
      post '/api/v1/products', params: {
        product: { name: '' }
      }, headers: {}

      res = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(res['errors']['base']).to eq('Unauthorized')
    end
  end

  describe "PUT /products/:id" do
    it "updates product" do
      put "/api/v1/products/#{product.id}", params: {
        product: { name: 'Updated product name' }
      }, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      product.reload
      expect(product.name).to eq('Updated product name')
    end

    it "returns error if it is not logged in seller product" do
      put "/api/v1/products/#{other_product.id}", params: {
        product: { name: 'Updated product name' }
      }, headers: headers

      res = JSON.parse(response.body)

      expect(response).to have_http_status(404)
      expect(res['errors']['base']).to eq("Record not found")
    end

    it "returns error if user is not logged in" do
      put "/api/v1/products/#{other_product.id}", params: {
        product: { name: 'Updated product name' }
      }, headers: {}

      res = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(res['errors']['base']).to eq('Unauthorized')
    end
  end
end
