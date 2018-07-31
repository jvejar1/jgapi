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

ActiveRecord::Schema.define(version: 20180731025227) do

  create_table "acase_answers", force: :cascade do |t|
    t.integer "evaluation_id"
    t.integer "acase_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "selected_feeling"
    t.index ["acase_id"], name: "index_acase_answers_on_acase_id"
    t.index ["evaluation_id"], name: "index_acase_answers_on_evaluation_id"
  end

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
    t.integer "correct_feeling"
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
    t.boolean "example"
    t.index ["corsi_id"], name: "index_corsi_csequences_on_corsi_id"
    t.index ["csequence_id"], name: "index_corsi_csequences_on_csequence_id"
  end

  create_table "corsi_evaluations", force: :cascade do |t|
    t.integer "corsi_id"
    t.integer "student_id"
    t.integer "ordered_score"
    t.integer "reversed_score"
    t.integer "ordered_practice_tries"
    t.integer "reversed_practice_tries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "realized_at"
    t.integer "user_id"
    t.index ["corsi_id"], name: "index_corsi_evaluations_on_corsi_id"
    t.index ["student_id"], name: "index_corsi_evaluations_on_student_id"
    t.index ["user_id"], name: "index_corsi_evaluations_on_user_id"
  end

  create_table "corsis", force: :cascade do |t|
    t.decimal "version"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "level"
    t.integer "letter"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "csequence_answers", force: :cascade do |t|
    t.integer "csequence_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "evaluation_id"
    t.float "time_in_seconds"
    t.string "answer_string"
    t.integer "corsi_evaluation_id"
    t.index ["corsi_evaluation_id"], name: "index_csequence_answers_on_corsi_evaluation_id"
    t.index ["csequence_id"], name: "index_csequence_answers_on_csequence_id"
    t.index ["evaluation_id"], name: "index_csequence_answers_on_evaluation_id"
  end

  create_table "csequences", force: :cascade do |t|
    t.boolean "ordered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "time_limit"
    t.string "csequence"
  end

  create_table "csquares", force: :cascade do |t|
    t.integer "square"
    t.integer "csequence_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csequence_id"], name: "index_csquares_on_csequence_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "student_id"
    t.integer "wally_id"
    t.integer "fonotest_id"
    t.integer "hnfset_id"
    t.datetime "realized_at"
    t.integer "ace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_score"
    t.index ["ace_id"], name: "index_evaluations_on_ace_id"
    t.index ["fonotest_id"], name: "index_evaluations_on_fonotest_id"
    t.index ["hnfset_id"], name: "index_evaluations_on_hnfset_id"
    t.index ["student_id"], name: "index_evaluations_on_student_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
    t.index ["wally_id"], name: "index_evaluations_on_wally_id"
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

  create_table "fonotest_items", force: :cascade do |t|
    t.integer "fonotest_id"
    t.integer "item_id"
    t.string "name"
    t.boolean "example"
    t.integer "index"
    t.string "instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fonotest_id"], name: "index_fonotest_items_on_fonotest_id"
    t.index ["item_id"], name: "index_fonotest_items_on_item_id"
  end

  create_table "fonotests", force: :cascade do |t|
    t.decimal "version"
    t.boolean "current"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hnf_answers", force: :cascade do |t|
    t.integer "evaluation_id"
    t.integer "hnftest_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "time_in_seconds"
    t.integer "corrects"
    t.integer "omitted"
    t.integer "total_errors"
    t.integer "practice_tries"
    t.index ["evaluation_id"], name: "index_hnf_answers_on_evaluation_id"
    t.index ["hnftest_id"], name: "index_hnf_answers_on_hnftest_id"
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

  create_table "item_answers", force: :cascade do |t|
    t.integer "evaluation_id"
    t.integer "item_id"
    t.string "answer_string"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_item_answers_on_evaluation_id"
    t.index ["item_id"], name: "index_item_answers_on_item_id"
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

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "rut"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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

  create_table "wsituation_answers", force: :cascade do |t|
    t.integer "wfeeling_answer"
    t.integer "wreaction_answer"
    t.integer "wsituation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "evaluation_id"
    t.index ["evaluation_id"], name: "index_wsituation_answers_on_evaluation_id"
    t.index ["wsituation_id"], name: "index_wsituation_answers_on_wsituation_id"
  end

  create_table "wsituations", force: :cascade do |t|
    t.integer "picture_id"
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wsituations_on_picture_id"
  end

end
