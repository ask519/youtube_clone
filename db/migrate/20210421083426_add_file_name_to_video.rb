class AddFileNameToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :file_name, :string
  end
end
