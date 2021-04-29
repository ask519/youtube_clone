class AddIndices < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :uid

    add_index :videos, :file_name

    add_index :likes, :reference
    add_index :likes, :like_on

    add_index :comments, :reference
  end
end
