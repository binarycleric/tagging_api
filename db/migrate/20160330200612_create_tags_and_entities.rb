class CreateTagsAndEntities < ActiveRecord::Migration
  def change
    create_table :tags, id: false do |t|
      t.uuid :id, primary_key: true
      t.string :name
      t.timestamps null: false
    end

    create_table :entities, id: false do |t|
      t.uuid :id, primary_key: true
      t.integer :entity_type_id
      t.timestamps null: false
    end

    create_table :entity_types do |t|
      t.string :name
    end

    create_table :entity_tags do |t|
      t.uuid :entity_id
      t.uuid :tag_id
      t.timestamps null: false
    end

    # TODO: Indexes.

  end
end
