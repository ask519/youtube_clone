class User < ApplicationRecord
  has_many :videos
  validates :name, :email, :uid, :presence=> true
end
