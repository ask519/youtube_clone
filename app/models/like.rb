class Like < ApplicationRecord
  belongs_to :user
  enum like_on: [:video, :comment]
  validates :user_id, :reference, :like_on, :presence => true
end
