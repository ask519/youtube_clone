class Comment < ApplicationRecord
  belongs_to :user
  validates :user_id, :reference, :body, :presence => true
end
