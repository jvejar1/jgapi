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

ActiveRecord::Schema.define(version: 20200102202603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acase_answers", force: :cascade do |t|
    t.bigint "evaluation_id"
    t.bigint "acase_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "selected_feeling"
    t.index ["acase_id"], name: "index_acase_answers_on_acase_id"
    t.index ["evaluation_id"], name: "index_acase_answers_on_evaluation_id"
  end

  create_table "acase_correct_feelings", force: :cascade do |t|
    t.bigint "acase_id"
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
    t.bigint "picture_id"
    t.index ["picture_id"], name: "index_acases_on_picture_id"
  end

  create_table "ace_acases", force: :cascade do |t|
    t.bigint "ace_id"
    t.bigint "acase_id"
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
    t.bigint "corsi_id"
    t.bigint "csequence_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "example"
    t.index ["corsi_id"], name: "index_corsi_csequences_on_corsi_id"
    t.index ["csequence_id"], name: "index_corsi_csequences_on_csequence_id"
  end

  create_table "corsi_evaluations", force: :cascade do |t|
    t.bigint "corsi_id"
    t.bigint "student_id"
    t.integer "ordered_score"
    t.integer "reversed_score"
    t.integer "ordered_practice_tries"
    t.integer "reversed_practice_tries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "realized_at"
    t.bigint "user_id"
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
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "csequence_answers", force: :cascade do |t|
    t.bigint "csequence_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.float "time_in_seconds"
    t.string "answer_string"
    t.bigint "corsi_evaluation_id"
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
    t.bigint "csequence_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csequence_id"], name: "index_csquares_on_csequence_id"
  end

  create_table "evaluation_migrations", force: :cascade do |t|
    t.bigint "evaluation_from_id"
    t.bigint "evaluation_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_from_id"], name: "index_evaluation_migrations_on_evaluation_from_id"
    t.index ["evaluation_to_id"], name: "index_evaluation_migrations_on_evaluation_to_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "student_id"
    t.bigint "wally_id"
    t.bigint "fonotest_id"
    t.bigint "hnfset_id"
    t.datetime "realized_at"
    t.bigint "ace_id"
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

  create_table "fonotest_items", force: :cascade do |t|
    t.bigint "fonotest_id"
    t.bigint "item_id"
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
    t.bigint "evaluation_id"
    t.bigint "hnftest_id"
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
    t.bigint "hnfset_id"
    t.bigint "hnftest_id"
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
    t.bigint "hnftest_id"
    t.index ["hnftest_id"], name: "index_hnftest_figures_on_hnftest_id"
  end

  create_table "hnftests", force: :cascade do |t|
    t.integer "hnf_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_answers", force: :cascade do |t|
    t.bigint "evaluation_id"
    t.bigint "item_id"
    t.string "answer_string"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_item_answers_on_evaluation_id"
    t.index ["item_id"], name: "index_item_answers_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "audio_id"
    t.string "description"
    t.string "correct_sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audio_id"], name: "index_items_on_audio_id"
  end

  create_table "moments", force: :cascade do |t|
    t.date "from"
    t.date "until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "study_id"
    t.index ["study_id"], name: "index_moments_on_study_id"
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
    t.bigint "commune_id"
    t.string "street"
    t.string "street_number"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group"
    t.index ["commune_id"], name: "index_schools_on_commune_id"
  end

  create_table "situation_sets", force: :cascade do |t|
    t.bigint "wally_id"
    t.bigint "wsituation_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wally_id"], name: "index_situation_sets_on_wally_id"
    t.index ["wsituation_id"], name: "index_situation_sets_on_wsituation_id"
  end

  create_table "student_courses", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.date "entry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_courses_on_course_id"
    t.index ["student_id"], name: "index_student_courses_on_student_id"
  end

  create_table "student_name_changes", force: :cascade do |t|
    t.bigint "student_id"
    t.string "old_name"
    t.string "new_name"
    t.string "old_last_name"
    t.string "new_last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_name_changes_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "rut"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.boolean "active", default: true
    t.bigint "id_rut"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

  create_table "studies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "study_courses", force: :cascade do |t|
    t.bigint "study_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group"
    t.index ["course_id"], name: "index_study_courses_on_course_id"
    t.index ["study_id"], name: "index_study_courses_on_study_id"
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
    t.integer "role"
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
    t.bigint "picture_id"
    t.integer "wfeeling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wfeelings_on_picture_id"
  end

  create_table "wreactions", force: :cascade do |t|
    t.string "description"
    t.integer "wreaction"
    t.bigint "picture_id"
    t.bigint "wsituation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wreactions_on_picture_id"
    t.index ["wsituation_id"], name: "index_wreactions_on_wsituation_id"
  end

  create_table "wsituation_answers", force: :cascade do |t|
    t.integer "wfeeling_answer"
    t.integer "wreaction_answer"
    t.bigint "wsituation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.index ["evaluation_id"], name: "index_wsituation_answers_on_evaluation_id"
    t.index ["wsituation_id"], name: "index_wsituation_answers_on_wsituation_id"
  end

  create_table "wsituations", force: :cascade do |t|
    t.bigint "picture_id"
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_wsituations_on_picture_id"
  end

  add_foreign_key "acase_answers", "acases"
  add_foreign_key "acase_answers", "evaluations"
  add_foreign_key "acase_correct_feelings", "acases"
  add_foreign_key "acases", "pictures"
  add_foreign_key "ace_acases", "acases"
  add_foreign_key "ace_acases", "aces"
  add_foreign_key "corsi_csequences", "corsis"
  add_foreign_key "corsi_csequences", "csequences"
  add_foreign_key "corsi_evaluations", "corsis"
  add_foreign_key "corsi_evaluations", "students"
  add_foreign_key "corsi_evaluations", "users"
  add_foreign_key "courses", "schools"
  add_foreign_key "csequence_answers", "corsi_evaluations"
  add_foreign_key "csequence_answers", "csequences"
  add_foreign_key "csequence_answers", "evaluations"
  add_foreign_key "csquares", "csequences"
  add_foreign_key "evaluation_migrations", "evaluations", column: "evaluation_from_id"
  add_foreign_key "evaluation_migrations", "evaluations", column: "evaluation_to_id"
  add_foreign_key "evaluations", "aces"
  add_foreign_key "evaluations", "fonotests"
  add_foreign_key "evaluations", "hnfsets"
  add_foreign_key "evaluations", "students"
  add_foreign_key "evaluations", "users"
  add_foreign_key "evaluations", "wallies"
  add_foreign_key "fonotest_items", "fonotests"
  add_foreign_key "fonotest_items", "items"
  add_foreign_key "hnf_answers", "evaluations"
  add_foreign_key "hnf_answers", "hnftests"
  add_foreign_key "hnfset_hnftests", "hnfsets"
  add_foreign_key "hnfset_hnftests", "hnftests"
  add_foreign_key "hnftest_figures", "hnftests"
  add_foreign_key "item_answers", "evaluations"
  add_foreign_key "item_answers", "items"
  add_foreign_key "items", "audios"
  add_foreign_key "moments", "studies"
  add_foreign_key "schools", "communes"
  add_foreign_key "situation_sets", "wallies"
  add_foreign_key "situation_sets", "wsituations"
  add_foreign_key "student_courses", "courses"
  add_foreign_key "student_courses", "students"
  add_foreign_key "student_name_changes", "students"
  add_foreign_key "students", "courses"
  add_foreign_key "study_courses", "courses"
  add_foreign_key "study_courses", "studies"
  add_foreign_key "wfeelings", "pictures"
  add_foreign_key "wreactions", "pictures"
  add_foreign_key "wreactions", "wsituations"
  add_foreign_key "wsituation_answers", "evaluations"
  add_foreign_key "wsituation_answers", "wsituations"
  add_foreign_key "wsituations", "pictures"
end
