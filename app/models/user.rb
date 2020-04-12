class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_products, through: :reviews, source: :product
    has_many :products #products that they created

    validates :username, uniqueness: true, presence: true
    validates :email, presence: true

    has_secure_password

    def self.from_google(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |user|
            user.username = auth.info.name
            user.password = SecureRandom.hex
          end
    end

end
