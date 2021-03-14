class AddSymbolToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :symbol, :string
    add_column :news, :original_created_at, :datetime
  end
end
