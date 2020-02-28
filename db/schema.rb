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

ActiveRecord::Schema.define(version: 20200113131514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "blockeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "blockee_id"
    t.index ["user_id"], name: "index_blockeds_on_user_id"
  end

  create_table "conversations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crushes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_crushes_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "fake_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "photo"
    t.integer "age"
    t.string "member_gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "users_id"
    t.uuid "user_details_id"
    t.index ["user_details_id"], name: "index_fake_users_on_user_details_id"
    t.index ["users_id"], name: "index_fake_users_on_users_id"
  end

  create_table "favorites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "favorite_of"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "text"
    t.uuid "user_id"
    t.uuid "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.boolean "private"
    t.boolean "primary"
    t.integer "x"
    t.integer "y"
    t.integer "width"
    t.integer "height"
    t.string "cropped_url"
    t.string "remote_url"
    t.string "string"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "physical_informations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "height"
    t.string "ethnicity"
    t.string "hair_color"
    t.string "eye_color"
    t.boolean "smoker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationship_soughts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "exciting"
    t.boolean "long_term"
    t.boolean "anything"
    t.boolean "short_term"
    t.boolean "undecided"
    t.boolean "virtual"
  end

  create_table "relationship_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "smiley_receiveds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smileys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "receiver"
    t.index ["user_id"], name: "index_smileys_on_user_id"
  end

  create_table "user_conversations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_user_conversations_on_conversation_id"
    t.index ["user_id"], name: "index_user_conversations_on_user_id"
  end

  create_table "user_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "marital_status"
    t.string "occupation"
    t.integer "income"
    t.datetime "birthday"
    t.boolean "looking_exciting"
    t.boolean "looking_long"
    t.boolean "looking_anything"
    t.boolean "looking_short"
    t.boolean "looking_undecided"
    t.boolean "looking_virtual"
    t.integer "height"
    t.string "hair_color"
    t.string "eye_color"
    t.boolean "smoker"
    t.uuid "user_id"
    t.string "name"
    t.boolean "anything_goes"
    t.boolean "being_dominated"
    t.boolean "dominating"
    t.boolean "normal"
    t.boolean "threesome"
    t.boolean "secret"
    t.boolean "active"
    t.boolean "shy"
    t.boolean "sociable"
    t.boolean "modest"
    t.boolean "fun"
    t.boolean "generous"
    t.boolean "spiritual"
    t.boolean "moody"
    t.boolean "relaxed"
    t.boolean "sensitive"
    t.boolean "aerobics"
    t.boolean "golf"
    t.boolean "martial_arts"
    t.boolean "soccer"
    t.boolean "walking"
    t.boolean "rugby"
    t.boolean "swimming"
    t.boolean "baseball"
    t.boolean "cycling"
    t.boolean "running"
    t.boolean "tennis"
    t.boolean "weight"
    t.boolean "basketball"
    t.boolean "dance"
    t.boolean "skiing"
    t.boolean "volleyball"
    t.boolean "bowling"
    t.boolean "hockey"
    t.boolean "arts"
    t.boolean "cooking"
    t.boolean "hiking"
    t.boolean "networking"
    t.boolean "video_games"
    t.boolean "book"
    t.boolean "dining_out"
    t.boolean "movies"
    t.boolean "nightclubs"
    t.boolean "religion"
    t.boolean "charities"
    t.boolean "museums"
    t.boolean "shopping"
    t.boolean "wine"
    t.boolean "coffee"
    t.boolean "gardening"
    t.boolean "pets"
    t.boolean "music"
    t.boolean "being_blinded"
    t.boolean "costume"
    t.boolean "role_playing"
    t.boolean "using_sex_toys"
    t.boolean "unusual_places"
    t.boolean "being_watched"
    t.boolean "willing_experiment"
    t.boolean "cultivated"
    t.boolean "imaginative"
    t.boolean "independent"
    t.boolean "mature"
    t.boolean "outgoing"
    t.boolean "self_confident"
    t.boolean "reliable"
    t.boolean "sophisticated"
    t.integer "inches"
    t.integer "feet"
    t.uuid "fake_users_id"
    t.index ["fake_users_id"], name: "index_user_details_on_fake_users_id"
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "birthdate"
    t.integer "min_age"
    t.integer "max_age"
    t.integer "max_radius"
    t.datetime "last_login"
    t.datetime "last_logout"
    t.integer "zip_code"
    t.float "longitude"
    t.float "latitude"
    t.uuid "genders_id"
    t.uuid "user_details_id"
    t.uuid "relationship_soughts_id"
    t.uuid "physical_informations_id"
    t.string "photo"
    t.boolean "member"
    t.string "email"
    t.integer "age"
    t.string "member_gender"
    t.string "gender_interest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_email_token"
    t.datetime "reset_email_sent_at"
    t.boolean "disabled"
    t.string "reason_deactivate"
    t.string "comment_deactivate"
    t.boolean "real"
    t.boolean "online", default: false
    t.boolean "manually_online"
    t.datetime "scheduled_log_in"
    t.datetime "scheduled_log_out"
    t.uuid "fake_users_id"
    t.boolean "looking_online_members"
    t.string "city"
    t.boolean "confirmed_user"
    t.integer "activation_code"
    t.integer "remaining_messages"
    t.boolean "looking_photos_members"
    t.index ["fake_users_id"], name: "index_users_on_fake_users_id"
    t.index ["genders_id"], name: "index_users_on_genders_id"
    t.index ["physical_informations_id"], name: "index_users_on_physical_informations_id"
    t.index ["relationship_soughts_id"], name: "index_users_on_relationship_soughts_id"
    t.index ["user_details_id"], name: "index_users_on_user_details_id"
  end

  create_table "visitors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "visitee_id"
    t.index ["user_id"], name: "index_visitors_on_user_id"
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "user_conversations", "conversations"
  add_foreign_key "user_conversations", "users"
end
