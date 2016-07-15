class AddFieldsToPad < ActiveRecord::Migration
  def change
    add_column :pads, :latitude, :float
    add_column :pads, :longitude, :float
  end
end
