class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :role, :seller, :balance

  def seller
    object.seller?
  end

  def balance
    object.balance
  end
end
