class RemoveTimestampsFromCacheTables < ActiveRecord::Migration[6.1]
  def change
    remove_column :cache_tables, :created_at, :string
    remove_column :cache_tables, :updated_at, :string
  end
end
