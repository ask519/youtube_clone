class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :url_to_hls_playlist

      t.timestamps
    end
  end
end
