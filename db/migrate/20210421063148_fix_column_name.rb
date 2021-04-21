class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :videos, :url_to_hls_playlist, :playlist_url
    add_column :videos, :thumbnail_url, :string
  end
end
