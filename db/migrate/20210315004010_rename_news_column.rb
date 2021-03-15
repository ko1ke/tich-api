class RenameNewsColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :news, :abstract, :body
  end
end
