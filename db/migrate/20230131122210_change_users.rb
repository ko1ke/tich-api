class ChangeUsers < ActiveRecord::Migration[6.1]
  def up
    add_index :users, :uid, unique: true
    change_column :users, :uid, :string, null: false, default: ''
    change_column :users, :email, :string, null: false, default: ''
  end

  def down
    remove_index :users, :uid, unique: true
    change_column :users, :uid, :string, null: false
    change_column :users, :email, :string, null: false
  end
end
