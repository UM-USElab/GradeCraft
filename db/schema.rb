# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120721014941) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.integer  "weight"
    t.string   "response_class"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.boolean  "is_exclusive"
    t.integer  "display_length"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "default_value"
    t.string   "api_id"
    t.string   "display_type"
  end

  create_table "assignment_types", :force => true do |t|
    t.string   "name"
    t.string   "point_setting"
    t.integer  "levels"
    t.string   "points_predictor_display"
    t.boolean  "due_date"
    t.integer  "resubmission"
    t.integer  "max_value"
    t.integer  "percentage_course"
    t.string   "predictor_description"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "course_id"
    t.integer  "universal_point_value"
    t.integer  "minimum_score"
    t.integer  "step_value",               :default => 1
    t.integer  "grade_scheme_id"
  end

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "point_total"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
    t.integer  "type",               :limit => 255
    t.boolean  "present"
    t.integer  "course_id"
    t.integer  "assignment_type_id"
    t.integer  "grade_scheme_id"
  end

  create_table "badge_sets", :force => true do |t|
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "badges", :force => true do |t|
    t.integer   "assignment_id"
    t.string    "title"
    t.text      "description"
    t.string    "icon"
    t.binary    "visible"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.string    "occurrence"
    t.integer   "badge_set_id"
  end

  add_index "badges", ["assignment_id"], :name => "index_badges_on_assignment_id"

  create_table "challenge_grades", :force => true do |t|
    t.integer   "score"
    t.string    "feedback"
    t.integer   "team_id"
    t.integer   "challenge_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "type"
  end

  create_table "challenges", :force => true do |t|
    t.string   "title"
    t.integer  "points"
    t.string   "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "course_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "course_grade_schemes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "course_id"
    t.integer  "low_range"
    t.integer  "high_range"
    t.string   "letter_grade"
  end

  create_table "course_memberships", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "course_memberships", ["course_id", "user_id"], :name => "index_courses_users_on_course_id_and_user_id"
  add_index "course_memberships", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "courseno"
    t.string   "year"
    t.string   "semester"
    t.decimal  "badge_set_id"
    t.string   "theme_id"
    t.integer  "coursegradescheme"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "team_setting"
    t.string   "user_term"
    t.boolean  "badge_setting"
    t.string   "team_term"
    t.string   "homepage_message"
    t.boolean  "status"
    t.boolean  "group_setting"
  end

  create_table "dashboards", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "dependencies", :force => true do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.string   "rule"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "dependency_conditions", :force => true do |t|
    t.integer  "dependency_id"
    t.string   "rule_key"
    t.integer  "question_id"
    t.string   "operator"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "earned_badges", :force => true do |t|
    t.integer   "grade_id"
    t.integer   "badge_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "grade_scheme_elements", :force => true do |t|
    t.string   "name"
    t.integer  "low_range"
    t.integer  "high_range"
    t.string   "letter_grade"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "grade_scheme_id"
  end

  create_table "grade_schemes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "scheme_name"
    t.integer  "course_id"
  end

  create_table "grades", :force => true do |t|
    t.integer   "score"
    t.integer   "user_id"
    t.integer   "assignment_id"
    t.text      "feedback"
    t.integer   "badge_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "complete"
    t.boolean   "semis"
    t.boolean   "finals"
    t.string    "type"
    t.string    "status"
    t.boolean   "attempted"
    t.boolean   "substantial"
  end

  add_index "grades", ["assignment_id"], :name => "index_grades_on_assignment_id"
  add_index "grades", ["badge_id"], :name => "index_grades_on_badge_id"
  add_index "grades", ["user_id"], :name => "index_grades_on_user_id"

  create_table "groups", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "assignment_id"
    t.integer   "course_id"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  create_table "question_groups", :force => true do |t|
    t.text     "text"
    t.text     "help_text"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "api_id"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_section_id"
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.string   "pick"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "display_type"
    t.boolean  "is_mandatory"
    t.integer  "display_width"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "correct_answer_id"
    t.string   "api_id"
  end

  create_table "response_sets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.string   "access_code"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "api_id"
  end

  add_index "response_sets", ["access_code"], :name => "response_sets_ac_idx", :unique => true

  create_table "responses", :force => true do |t|
    t.integer  "response_set_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "response_group"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "survey_section_id"
    t.string   "api_id"
  end

  add_index "responses", ["survey_section_id"], :name => "index_responses_on_survey_section_id"

  create_table "survey_sections", :force => true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.text     "description"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "custom_class"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "access_code"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.string   "css_url"
    t.string   "custom_class"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "display_order"
    t.string   "api_id"
  end

  add_index "surveys", ["access_code"], :name => "surveys_ac_idx", :unique => true

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.integer  "sortable_score"
    t.integer  "rank"
    t.integer  "course_id"
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.string   "filename"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "username",                                               :null => false
    t.string    "email"
    t.string    "crypted_password"
    t.string    "salt"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "reset_password_token"
    t.timestamp "reset_password_token_expires_at"
    t.timestamp "reset_password_email_sent_at"
    t.string    "remember_me_token"
    t.timestamp "remember_me_token_expires_at"
    t.string    "avatar_file_name"
    t.string    "avatar_content_type"
    t.integer   "avatar_file_size"
    t.timestamp "avatar_updated_at"
    t.string    "role",                            :default => "student"
    t.integer   "team_id"
    t.string    "first_name"
    t.string    "last_name"
    t.integer   "sortable_score"
    t.integer   "rank"
    t.string    "display_name"
    t.boolean   "private_display",                 :default => false
    t.integer   "default_course_id"
    t.string    "final_grade"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "validation_conditions", :force => true do |t|
    t.integer  "validation_id"
    t.string   "rule_key"
    t.string   "operator"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "regexp"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "validations", :force => true do |t|
    t.integer  "answer_id"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
