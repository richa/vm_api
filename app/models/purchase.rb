class Purchase < ApplicationRecord
  ## VALIDATIONS ##
  validates :user, :product, :quantity, :amount, presence: true
  validates :quantity, numericality: { greater_than: 0, allow_blank: true }

  ## ASSOCIATIONS ##
  belongs_to :product
  belongs_to :user

  ## CALLBACKS ##
  before_validation :set_amount
  validate :check_user_balance
  validate :check_product_stock
  after_save :update_product_stock
  after_save :update_user_balance

  ## PRIVATE METHODS ##
  private
  def set_amount
    return unless product && quantity
    self.amount = product.cost * quantity
  end

  def check_user_balance
    if amount > user.deposit
      self.errors.add(:user, 'Insufficient balance.')
      return false
    end
  end

  def check_product_stock
    if quantity > product.amount_available
      self.errors.add(:product, 'Insufficient products in stock.')
      return false
    end
  end

  def update_product_stock
    final_quantity = product.amount_available - quantity
    self.product.update_attribute(:amount_available, final_quantity)
  end

  def update_user_balance
    balance = user.deposit - amount
    self.user.update_attribute(:deposit, balance)
  end
end
