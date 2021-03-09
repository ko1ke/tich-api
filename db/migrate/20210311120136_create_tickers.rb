class CreateTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :tickers do |t|
      t.string :index, null: false
      t.string :symbol, null: false
      t.string :formal_name, null: false

      t.timestamps
    end
  end
end
