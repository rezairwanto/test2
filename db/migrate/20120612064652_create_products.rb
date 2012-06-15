class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :weight
      t.integer :user_id
      t.integer :categories_id
      t.timestamps
    end
  end
end
