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

ActiveRecord::Schema.define(version: 2021_11_18_153507) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "playlist_streamers", force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "streamer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["playlist_id"], name: "index_playlist_streamers_on_playlist_id"
    t.index ["streamer_id"], name: "index_playlist_streamers_on_streamer_id"
  end

  create_table "playlist_videos", force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["playlist_id"], name: "index_playlist_videos_on_playlist_id"
    t.index ["video_id"], name: "index_playlist_videos_on_video_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "related_playlists", force: :cascade do |t|
    t.integer "original_playlist_id", null: false
    t.integer "related_playlist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "streamer_videos", force: :cascade do |t|
    t.integer "streamer_id", null: false
    t.integer "video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["streamer_id"], name: "index_streamer_videos_on_streamer_id"
    t.index ["video_id"], name: "index_streamer_videos_on_video_id"
  end

  create_table "streamers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "facebook_url"
    t.string "youtube_url"
    t.string "instagram_handle"
    t.string "twitter_handle"
    t.index ["facebook_url"], name: "index_streamers_on_facebook_url", unique: true
    t.index ["instagram_handle"], name: "index_streamers_on_instagram_handle", unique: true
    t.index ["name"], name: "index_streamers_on_name", unique: true
    t.index ["twitter_handle"], name: "index_streamers_on_twitter_handle", unique: true
    t.index ["youtube_url"], name: "index_streamers_on_youtube_url", unique: true
  end

  create_table "subscription_plan_values", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "value"
    t.integer "subscription_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 10
    t.index ["subscription_plan_id", "end_date"], name: "by_plan_and_end_date", unique: true
    t.index ["subscription_plan_id", "start_date"], name: "by_plan_and_start_date", unique: true
    t.index ["subscription_plan_id"], name: "index_subscription_plan_values_on_subscription_plan_id"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_subscription_plans_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "duration"
    t.string "video_url"
    t.string "maturity_rating"
    t.index ["title"], name: "index_videos_on_title", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "playlist_streamers", "playlists"
  add_foreign_key "playlist_streamers", "streamers"
  add_foreign_key "playlist_videos", "playlists"
  add_foreign_key "playlist_videos", "videos"
  add_foreign_key "related_playlists", "playlists", column: "original_playlist_id"
  add_foreign_key "related_playlists", "playlists", column: "related_playlist_id"
  add_foreign_key "streamer_videos", "streamers"
  add_foreign_key "streamer_videos", "videos"
  add_foreign_key "subscription_plan_values", "subscription_plans"
  add_foreign_key "video_categories", "video_categories", column: "parent_id"
end
