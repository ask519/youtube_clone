class Video < ApplicationRecord
  belongs_to :user
  validates :name, :user_id, :url_to_hls_playlist, :presence => true
end
