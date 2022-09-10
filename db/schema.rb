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

ActiveRecord::Schema[7.0].define(version: 2022_09_09_172735) do
  create_table "chats", force: :cascade do |t|
    t.integer "user1_id"
    t.integer "user2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user1_id"], name: "index_chats_on_user1_id"
    t.index ["user2_id"], name: "index_chats_on_user2_id"
  end

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
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.string "creator"
    t.string "description"
    t.string "playlist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_reccomendations", force: :cascade do |t|
    t.string "body"
    t.string "resource_img"
    t.binary "viewed"
    t.integer "community_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_reccomendations_on_community_id"
    t.index ["user_id"], name: "index_community_reccomendations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.date "start_date"
    t.integer "community_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "chat_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "modders", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_modders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_modders_on_reset_password_token", unique: true
  end

  create_table "participations", force: :cascade do |t|
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
    t.string "spotify_content"
    t.string "body"
    t.integer "community_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.string "uid"
    t.boolean "like"
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_reactions_on_post_id"
  end

  create_table "taggable_communities", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_taggable_communities_on_community_id"
    t.index ["tag_id"], name: "index_taggable_communities_on_tag_id"
  end

  create_table "taggable_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggable_users_on_tag_id"
    t.index ["user_id"], name: "index_taggable_users_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reccomendations", force: :cascade do |t|
    t.string "body"
    t.integer "resource_id", null: false
    t.string "resource_img"
    t.binary "viewed"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_reccomendations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.string "avatar_url"
    t.string "name"
    t.text "spotify_hash"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "comment_reactions", "comments"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "community_reccomendations", "communities"
  add_foreign_key "community_reccomendations", "users"
  add_foreign_key "events", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "reactions", "posts"
  add_foreign_key "taggable_communities", "communities"
  add_foreign_key "taggable_communities", "tags"
  add_foreign_key "taggable_users", "tags"
  add_foreign_key "taggable_users", "users"
  add_foreign_key "user_reccomendations", "users"
end
