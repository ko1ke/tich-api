class AddReferenceToPortfolio < ActiveRecord::Migration[6.0]
  def change
    remove_index :portfolios, :uid
    remove_column :portfolios, :uid, :string
    add_reference :portfolios, :user, index: true
  end
end
