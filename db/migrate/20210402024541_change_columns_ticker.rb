class ChangeColumnsTicker < ActiveRecord::Migration[6.0]
  def change
    change_column :tickers, :price, :decimal, precision: 8, scale: 3
    change_column :tickers, :change, :decimal, precision: 8, scale: 3
  end
end
