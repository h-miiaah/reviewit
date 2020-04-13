class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user #creator of the product
  has_many :reviews
  has_many :users, through: :reviews #people who reviewed the product

  def category_attributes=(attributes)
    self.category = Category.find_or_create_by(attributes) if !attributes[:name].empty?
    self.category
  end

end
