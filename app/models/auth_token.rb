class AuthToken < ApplicationRecord
  ## VALIDATIONS ##
  validates :token, presence: true

  ## ASSOCIATIONS ##
  belongs_to :user
end
