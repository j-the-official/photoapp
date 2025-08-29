class User < ApplicationRecord
    has_secure_password

    has_many :photos, dependent: :destroy

    validates :user_id, presence: true, uniqueness: true, length: { maximum: 255 }
end
