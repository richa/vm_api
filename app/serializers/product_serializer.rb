class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :amount_available

  belongs_to :seller, serializer: SellerSerializer
end
