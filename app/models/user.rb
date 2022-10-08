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

  def is_seller?
    role == 'seller'
  end

end
