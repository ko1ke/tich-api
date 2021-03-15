class RemoveIndexColumnFromTickers < ActiveRecord::Migration[6.0]
  def change
    remove_column :tickers, :index, :string
  end
end
