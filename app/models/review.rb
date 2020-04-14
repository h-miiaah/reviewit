class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :title, :content, presence: true

  #if user already reviewed a product and tries to review it again, it will say the user already reviewed that product
  validates :product, uniqueness: {scope: :user, message: "was already reviewed by you"}

end
