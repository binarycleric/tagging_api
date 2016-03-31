# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160330200612) do

  create_table "entities", force: :cascade do |t|
    t.integer  "entity_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "entities", ["entity_type_id"], name: "index_entities_on_entity_type_id"
  add_index "entities", ["id"], name: "sqlite_autoindex_entities_1", unique: true

  create_table "entity_tags", force: :cascade do |t|
    t.uuid     "entity_id",  limit: 16
    t.uuid     "tag_id",     limit: 16
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "entity_tags", ["entity_id", "tag_id"], name: "index_entity_tags_on_entity_id_and_tag_id", unique: true

  create_table "entity_types", force: :cascade do |t|
    t.string "name"
  end

  add_index "entity_types", ["name"], name: "index_entity_types_on_name", unique: true

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["id"], name: "sqlite_autoindex_tags_1", unique: true
  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
