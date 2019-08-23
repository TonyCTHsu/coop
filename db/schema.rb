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

ActiveRecord::Schema.define(version: 20190822161012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
  end

  create_table "authors_package_versions", id: false, force: :cascade do |t|
    t.bigint "package_version_id", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_authors_package_versions_on_author_id"
    t.index ["package_version_id", "author_id"], name: "author_package_version_uniq_idx", unique: true
    t.index ["package_version_id"], name: "index_authors_package_versions_on_package_version_id"
  end

  create_table "package_versions", force: :cascade do |t|
    t.string "name", null: false
    t.string "version", null: false
    t.string "title"
    t.text "description"
    t.string "maintainer_string"
    t.string "authors_string"
    t.datetime "published_at"
    t.bigint "maintainer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["maintainer_id"], name: "index_package_versions_on_maintainer_id"
    t.index ["name", "version"], name: "index_package_versions_on_name_and_version", unique: true
  end

end
