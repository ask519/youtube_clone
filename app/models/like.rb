class Like < ApplicationRecord
  belongs_to :user
  enum like_on: [:video, :comment]
end
