class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user #creator of the product
  has_many :reviews
  has_many :users, through: :reviews #people who reviewed the product
end
