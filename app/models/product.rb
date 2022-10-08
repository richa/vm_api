class Product < ApplicationRecord
  ## VALIDATIONS ##
  validates :name, :cost, presence: true

  ## ASSOCIATIONS ##
  belongs_to :seller, class_name: 'User'
end
