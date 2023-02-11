class AddRankToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rank, :integer, default: 0
  end
end
