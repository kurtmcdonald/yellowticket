class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.float :discounted_price
      t.boolean :discounted
      t.date :sell_by_date
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
