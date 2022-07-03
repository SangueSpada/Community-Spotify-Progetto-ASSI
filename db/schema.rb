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

ActiveRecord::Schema[7.0].define(version: 2022_07_02_154312) do
  create_table "comment_reactions", force: :cascade do |t|
    t.string "uid"
    t.boolean "like"
    t.integer "comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_reactions_on_comment_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "body"
    t.string "author"
    t.integer "post_id", null: false
    t.integer "community_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_post_id"], name: "index_comments_on_community_post_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.string "creator"
    t.string "description"
    t.string "playlist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_posts", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.string "author"
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_posts_on_community_id"
  end

  create_table "participations", id: false, force: :cascade do |t|
    t.integer "community_id"
    t.integer "user_id"
    t.integer "role", default: 0
    t.boolean "banned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_participations_on_community_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reactions", force: :cascade do |t|
    t.string "uid"
    t.boolean "like"
    t.integer "post_id", null: false
    t.integer "community_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_post_id"], name: "index_reactions_on_community_post_id"
    t.index ["post_id"], name: "index_reactions_on_post_id"
  end

  create_table "taggables", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_taggables_on_community_id"
    t.index ["tag_id"], name: "index_taggables_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.string "avatar_url"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "comment_reactions", "comments"
  add_foreign_key "comments", "community_posts"
  add_foreign_key "comments", "posts"
  add_foreign_key "community_posts", "communities"
  add_foreign_key "reactions", "community_posts"
  add_foreign_key "reactions", "posts"
  add_foreign_key "taggables", "communities"
  add_foreign_key "taggables", "tags"
end
