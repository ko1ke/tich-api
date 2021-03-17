class AddOriginalIdToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :original_id, :string
  end
end
