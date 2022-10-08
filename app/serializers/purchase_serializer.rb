class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :user_balance

  belongs_to :product, serializer: ProductSerializer

  def user_balance
    object.user.balance
  end
end
