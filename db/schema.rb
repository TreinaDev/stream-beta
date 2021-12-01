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

ActiveRecord::Schema.define(version: 2021_11_30_221941) do

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

  create_table "payment_methods", force: :cascade do |t|
    t.string "token"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payment_type", default: 10, null: false
    t.index ["token"], name: "index_payment_methods_on_token", unique: true
    t.index ["user_id", "payment_type"], name: "index_payment_methods_on_user_id_and_payment_type", unique: true
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
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
    t.integer "status", default: 5
  end

  create_table "product_receipts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "product_type", null: false
    t.integer "product_id", null: false
    t.integer "payment_method_id", null: false
    t.decimal "value"
    t.string "receipt_token"
    t.datetime "receipt_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_method_id"], name: "index_product_receipts_on_payment_method_id"
    t.index ["product_type", "product_id"], name: "index_product_receipts_on_product"
    t.index ["receipt_token"], name: "index_product_receipts_on_receipt_token", unique: true
    t.index ["user_id"], name: "index_product_receipts_on_user_id"
  end

  create_table "promotion_tickets", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.integer "discount"
    t.decimal "maximum_value_reduction"
    t.integer "maximum_uses"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_promotion_tickets_on_title", unique: true
  end

  create_table "related_playlists", force: :cascade do |t|
    t.integer "original_playlist_id", null: false
    t.integer "related_playlist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "streamers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "facebook_url"
    t.string "youtube_url"
    t.string "instagram_handle"
    t.string "twitter_handle"
    t.integer "status", default: 0
    t.index ["facebook_url"], name: "index_streamers_on_facebook_url", unique: true
    t.index ["instagram_handle"], name: "index_streamers_on_instagram_handle", unique: true
    t.index ["name"], name: "index_streamers_on_name", unique: true
    t.index ["twitter_handle"], name: "index_streamers_on_twitter_handle", unique: true
    t.index ["youtube_url"], name: "index_streamers_on_youtube_url", unique: true
  end

  create_table "subscription_plan_playlists", force: :cascade do |t|
    t.integer "subscription_plan_id", null: false
    t.integer "playlist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["playlist_id"], name: "index_subscription_plan_playlists_on_playlist_id"
    t.index ["subscription_plan_id"], name: "index_subscription_plan_playlists_on_subscription_plan_id"
  end

  create_table "subscription_plan_promotion_tickets", force: :cascade do |t|
    t.integer "subscription_plan_id", null: false
    t.integer "promotion_ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_ticket_id"], name: "index_subs_plan_promo_ticket_on_promo_ticket_id"
    t.index ["subscription_plan_id"], name: "index_subs_plan_promo_ticket_on_subs_plan_id"
  end

  create_table "subscription_plan_streamers", force: :cascade do |t|
    t.integer "subscription_plan_id", null: false
    t.integer "streamer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["streamer_id"], name: "index_subscription_plan_streamers_on_streamer_id"
    t.index ["subscription_plan_id"], name: "index_subscription_plan_streamers_on_subscription_plan_id"
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
    t.integer "plan_type", default: 10, null: false
    t.string "token", null: false
    t.integer "status", default: 15
    t.index ["title"], name: "index_subscription_plans_on_title", unique: true
    t.index ["token"], name: "index_subscription_plans_on_token", unique: true
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "cpf"
    t.string "zipcode"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_user_profiles_on_cpf", unique: true
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true
  end

  create_table "user_subscription_plans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subscription_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_token"
    t.string "payment_method_token"
    t.integer "status", default: 10, null: false
    t.datetime "status_date"
    t.index ["subscription_plan_id"], name: "index_user_subscription_plans_on_subscription_plan_id"
    t.index ["user_id"], name: "index_user_subscription_plans_on_user_id"
  end

  create_table "user_videos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "video_id", null: false
    t.string "product_token"
    t.string "payment_method_token"
    t.integer "status", default: 10, null: false
    t.datetime "status_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "video_id"], name: "index_user_videos_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_user_videos_on_user_id"
    t.index ["video_id"], name: "index_user_videos_on_video_id"
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
    t.index ["title"], name: "index_video_categories_on_title", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "duration"
    t.string "video_url"
    t.string "maturity_rating"
    t.integer "streamer_id", null: false
    t.integer "status", default: 0
    t.boolean "allow_purchase", default: false
    t.decimal "value"
    t.string "token"
    t.index ["streamer_id", "title"], name: "index_videos_on_streamer_id_and_title", unique: true
    t.index ["streamer_id"], name: "index_videos_on_streamer_id"
    t.index ["token"], name: "index_videos_on_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "playlist_streamers", "playlists"
  add_foreign_key "playlist_streamers", "streamers"
  add_foreign_key "playlist_videos", "playlists"
  add_foreign_key "playlist_videos", "videos"
  add_foreign_key "product_receipts", "payment_methods"
  add_foreign_key "product_receipts", "users"
  add_foreign_key "related_playlists", "playlists", column: "original_playlist_id"
  add_foreign_key "related_playlists", "playlists", column: "related_playlist_id"
  add_foreign_key "subscription_plan_playlists", "playlists"
  add_foreign_key "subscription_plan_playlists", "subscription_plans"
  add_foreign_key "subscription_plan_promotion_tickets", "promotion_tickets"
  add_foreign_key "subscription_plan_promotion_tickets", "subscription_plans"
  add_foreign_key "subscription_plan_streamers", "streamers"
  add_foreign_key "subscription_plan_streamers", "subscription_plans"
  add_foreign_key "subscription_plan_values", "subscription_plans"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "user_subscription_plans", "subscription_plans"
  add_foreign_key "user_subscription_plans", "users"
  add_foreign_key "user_videos", "users"
  add_foreign_key "user_videos", "videos"
  add_foreign_key "video_categories", "video_categories", column: "parent_id"
  add_foreign_key "videos", "streamers"
end
