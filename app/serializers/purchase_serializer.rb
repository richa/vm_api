class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :balance

  belongs_to :product, serializer: ProductSerializer

  def balance
    object.user.balance
  end
end
