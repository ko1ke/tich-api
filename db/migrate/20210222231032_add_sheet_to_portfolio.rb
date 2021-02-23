class AddSheetToPortfolio < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :sheet, :json, default: [], null: false

    remove_column :portfolios, :ticker, :string, null: false, default: ''
    remove_column :portfolios, :unit_price, :decimal
    remove_column :portfolios, :number, :integer
    remove_column :portfolios, :note, :text
  end
  add_index :portfolios, :uid
end
