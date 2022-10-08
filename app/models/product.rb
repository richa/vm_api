class Product < ApplicationRecord
  ## VALIDATIONS ##
  validates :name, :cost, presence: true
  validates :name, uniqueness: { allow_blank: true }

  ## ASSOCIATIONS ##
  belongs_to :seller, class_name: 'User'
end
