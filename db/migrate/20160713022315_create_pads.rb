class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :property_type
      t.string :pad_type
      t.integer :accommodate
      t.integer :total_pad
      t.string :pad_name
      t.text :summary
      t.string :address
      t.boolean :is_food
      t.boolean :is_water
      t.boolean :is_ac
      t.boolean :is_heater
      t.boolean :is_toy
      t.boolean :is_treat
      t.boolean :is_walk
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
