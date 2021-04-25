class Video < ApplicationRecord
  belongs_to :user
  validates :user_id, :file_name, :name, :presence => true
end
