class User < ApplicationRecord
  has_secure_password

  enum role: {
    buyer: 0,
    seller: 1
  }

  ## VALIDATIONS ##
  validates :username, presence: true
  validates :username, uniqueness: { allow_blank: true }

  ## ASSOCIATIONS ##
  has_many :auth_tokens
  has_many :products, foreign_key: :seller_id
  has_many :purchases

  ## INSTANCE METHODS ##
  def verify_password(pwd)
    if authenticate(pwd)
      token = SecureRandom.hex(32)
      if AuthToken.find_by_token(token)
        verify_password(pwd)
      end

      self.auth_tokens.create!(token: token)
      token
    end
  end

  def deposit_amount(amount)
    amount = amount.to_i
    return false unless ALLOWED_DEPOSIT_VALUES.include?(amount)

    self.update_attribute(:deposit, deposit+amount)
  end

  def balance
    hash = { total: deposit }
    current_deposit = deposit

    ALLOWED_DEPOSIT_VALUES.each do |coin|
      value = current_deposit/coin
      hash[coin] = value

      current_deposit = current_deposit%coin

      if ALLOWED_DEPOSIT_VALUES.last == coin
        hash[:unconverted] = current_deposit
      end
    end

    hash
  end
end
