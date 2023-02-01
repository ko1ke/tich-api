class ChangeTickers < ActiveRecord::Migration[6.1]
  def up
    change_column :tickers, :symbol, :string, null: false, default: ''
    change_column :tickers, :formal_name, :string, null: false, default: ''
  end

  def down
    change_column :tickers, :symbol, :string, null: false
    change_column :tickers, :formal_name, :string, null: false
  end
end
