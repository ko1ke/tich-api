class AddPriceAndChangeToTicker < ActiveRecord::Migration[6.0]
  def change
    add_column :tickers, :price, :decimal, default: 0
    add_column :tickers, :change, :decimal, default: 0
  end
end
