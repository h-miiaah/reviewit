class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_products, through: :reviews, source: :product
    has_many :products #products that they created

    validates :username, uniqueness: true, presence: true
    validates :email, presence: true

    has_secure_password
end
