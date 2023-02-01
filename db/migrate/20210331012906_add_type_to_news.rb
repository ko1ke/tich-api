class AddTypeToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :type, :string, null: false, default: 'News::Company'
  end
end
