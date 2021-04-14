class User < ApplicationRecord
  validates :name, :email, :uid, :presence=> true
end
