class CreateTagsAndEntities < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :uuid, limit: 36, null: false
      t.string :name
      t.timestamps null: false
    end
    add_index :tags, [:name], unique: true
    add_index :tags, :uuid

    create_table :entities do |t|
      t.string :uuid, limit: 36, null: false
      t.integer :entity_type_id
      t.timestamps null: false
    end
    add_index :entities, [:entity_type_id]
    add_index :entities, :uuid

    create_table :entity_types do |t|
      t.string :name
    end
    add_index :entity_types, [:name], unique: true

    create_table :entity_tags do |t|
      t.integer :entity_id
      t.integer :tag_id
      t.timestamps null: false
    end
    add_index :entity_tags, [:entity_id, :tag_id], unique: true
  end
end
