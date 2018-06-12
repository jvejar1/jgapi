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

ActiveRecord::Schema.define(version: 20180609051346) do

  create_table "acase_correct_feelings", force: :cascade do |t|
    t.integer "acase_id"
    t.integer "correct_feeling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acase_id"], name: "index_acase_correct_feelings_on_acase_id"
  end

  create_table "acases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex", limit: 1
    t.string "description"
    t.boolean "distractor"
    t.integer "picture_id"
    t.index ["picture_id"], name: "index_acases_on_picture_id"
  end

  create_table "ace_acases", force: :cascade do |t|
    t.integer "ace_id"
    t.integer "acase_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acase_id"], name: "index_ace_acases_on_acase_id"
    t.index ["ace_id"], name: "index_ace_acases_on_ace_id"
  end

  create_table "aces", force: :cascade do |t|
    t.integer "version"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "audio_file_name"
    t.string "audio_content_type"
    t.integer "audio_file_size"
    t.datetime "audio_updated_at"
  end

  create_table "communes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corsi_csequences", force: :cascade do |t|
    t.integer "corsi_id"
    t.integer "csequence_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corsi_id"], name: "index_corsi_csequences_on_corsi_id"
    t.index ["csequence_id"], name: "index_corsi_csequences_on_csequence_id"
  end

  create_table "corsis", force: :cascade do |t|
    t.decimal "version"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "csequences", force: :cascade do |t|
    t.boolean "ordered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "time_limit"
  end

  create_table "csquares", force: :cascade do |t|
    t.integer "square"
    t.integer "csequence_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csequence_id"], name: "index_csquares_on_csequence_id"
  end

  create_table "fgroup_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "fgroup_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fgroup_id"], name: "index_fgroup_items_on_fgroup_id"
    t.index ["item_id"], name: "index_fgroup_items_on_item_id"
  end

  create_table "fgroups", force: :cascade do |t|
    t.boolean "example"
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fonotest_fgroups", force: :cascade do |t|
    t.integer "index"
    t.integer "fonotest_id"
    t.integer "fgroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fgroup_id"], name: "index_fonotest_fgroups_on_fgroup_id"
    t.index ["fonotest_id"], name: "index_fonotest_fgroups_on_fonotest_id"
  end

  create_table "fonotests", force: :cascade do |t|
    t.decimal "version"
    t.boolean "current"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hnfset_hnftests", force: :cascade do |t|
    t.integer "hnfset_id"
    t.integer "hnftest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hnfset_id"], name: "index_hnfset_hnftests_on_hnfset_id"
    t.index ["hnftest_id"], name: "index_hnfset_hnftests_on_hnftest_id"
  end

  create_table "hnfsets", force: :cascade do |t|
    t.boolean "current"
    t.decimal "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hnftest_figures", force: :cascade do |t|
    t.integer "figure"
    t.integer "index"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hnftest_id"
    t.index ["hnftest_id"], name: "index_hnftest_figures_on_hnftest_id"
  end

  create_table "hnftests", force: :cascade do |t|
    t.integer "hnf_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "audio_id"
    t.string "description"
    t.string "correct_sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audio_id"], name: "index_items_on_audio_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "commune_id"
    t.string "street"
    t.string "street_number"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commune_id"], name: "index_schools_on_commune_id"
  end

  create_table "situation_sets", force: :cascade do |t|
    t.integer "wally_id"
    t.integer "wsituation_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wally_id"], name: "index_situation_sets_on_wally_id"
    t.index ["wsituation_id"], name: "index_situation_sets_on_wsituation_id"
  end

  create_table "student_schools", force: :cascade do |t|
    t.integer "student_id"
    t.integer "school_id"
    t.integer "school_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_student_schools_on_school_id"
    t.index ["school_level_id"], name: "index_student_schools_on_school_level_id"
    t.index ["student_id"], name: "index_student_schools_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "rut"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallies", force: :cascade do |t|
    t.decimal "version"
    t.text "description"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wfeelings", force: :cascade do |t|
    t.integer "picture_id"
    t.integer "wfeeling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wfeelings_on_picture_id"
  end

  create_table "wreactions", force: :cascade do |t|
    t.string "description"
    t.integer "wreaction"
    t.integer "picture_id"
    t.integer "wsituation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wreactions_on_picture_id"
    t.index ["wsituation_id"], name: "index_wreactions_on_wsituation_id"
  end

  create_table "wsituations", force: :cascade do |t|
    t.integer "picture_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wsituations_on_picture_id"
  end

end
