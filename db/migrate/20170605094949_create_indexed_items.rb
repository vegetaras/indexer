class CreateIndexedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :indexed_items do |t|
      t.string :url, null: false
      t.string :content
      t.timestamps
    end

    add_index :indexed_items, :url, unique: true
  end
end
