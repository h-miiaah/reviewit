class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user #creator of the product
  has_many :reviews
  has_many :users, through: :reviews #people who reviewed the product

  validates :name, :brand, :description, presence: true
  
  validate :not_duplicate

  def category_attributes=(attributes)
    self.category = Category.find_or_create_by(attributes) if !attributes[:name].empty?
    self.category
  end

  # custom validator to check if duplicate exists in the system
  def not_duplicate
    if Product.find_by(name: name, category_id: category_id)
      errors.add(:name, 'already exists in that category')
    end
  end

end
