class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.text :headline
      t.text :abstract
      t.text :link_url
      t.text :image_url
      t.string :fetched_from

      t.timestamps
    end
  end
end
