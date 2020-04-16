class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user #creator of the product
  has_many :reviews
  has_many :users, through: :reviews #people who reviewed the product

  validates :name, :brand, :description, presence: true
  
  # validate :not_duplicate (removed so edit option is available)

  #scope method to display the products grouped by name & average rating
  scope :order_by_rating, -> {left_joins(:reviews).group(:name).order('avg(stars) desc')}

  def category_attributes=(attributes)
    self.category = Category.find_or_create_by(attributes) if !attributes[:name].empty?
    self.category
  end

  # custom validator to check if duplicate exists in the system (removed so edit option is available)
  # def not_duplicate
  #   if Product.find_by(name: name, category_id: category_id)
  #     errors.add(:name, 'already exists in that category')
  #   end
  # end

  def product_and_category
    "#{name} : #{category.name}"
  end

  def self.alphabetically
    order(:name)
  end

  def self.search(params)
    products = Product.where("name LIKE ? or brand LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    products #returns the products containing the search params
  end

end
