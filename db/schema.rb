# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_04_22_140101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "post_visibility", ["public", "internal"]

  create_table "posts", force: :cascade do |t|
    t.uuid "uuid"
    t.string "title"
    t.string "slug"
    t.text "html"
    t.string "feature_image"
    t.boolean "featured"
    t.datetime "published_at"
    t.text "custom_excerpt"
    t.text "excerpt"
    t.integer "reading_time"
    t.boolean "access"
    t.boolean "comments"
    t.string "og_image"
    t.string "og_title"
    t.text "og_description"
    t.string "twitter_image"
    t.string "twitter_title"
    t.text "twitter_description"
    t.string "meta_title"
    t.text "meta_description"
    t.string "email_subject"
    t.text "frontmatter"
    t.string "feature_image_alt"
    t.string "feature_image_caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "visibility", default: "internal", enum_type: "post_visibility"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["uuid"], name: "index_posts_on_uuid", unique: true
    t.index ["visibility"], name: "index_posts_on_visibility"
  end

end
