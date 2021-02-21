class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.string :ticker, null: false
      t.decimal :unit_price
      t.integer :number
      t.string :uid, null: false
      t.text :note

      t.timestamps
    end
  end
end
