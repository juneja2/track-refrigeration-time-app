class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.boolean :is_freezer

      t.timestamps
    end
  end
end
