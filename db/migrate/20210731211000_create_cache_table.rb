class CreateCacheTable < ActiveRecord::Migration[6.1]
  def change
    create_table :cache_tables do |t|
      t.bigint  :item_id
      t.bigint  :time_outside
      t.boolean :prev_loc_is_freezer
      t.bigint  :last_time_stamp

      t.timestamps
    end

    add_index :cache_tables, :item_id, unique: true
  end
end
