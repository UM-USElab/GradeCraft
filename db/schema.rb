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

ActiveRecord::Schema.define(:version => 20120924051812) do

  create_table "assignment_submissions", :force => true do |t|
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.string   "feedback"
    t.string   "comment"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "link"
    t.integer  "submittable_id"
    t.string   "submittable_type"
  end

  create_table "assignment_types", :force => true do |t|
    t.string   "name"
    t.string   "point_setting"
    t.boolean  "levels"
    t.string   "points_predictor_display"
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
    t.boolean  "due_date_present"
    t.integer  "order_placement"
    t.string   "user_percentage_set"
    t.boolean  "mass_grade"
    t.string   "mass_grade_type"
  end

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "point_total"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
    t.boolean  "present"
    t.integer  "course_id"
    t.integer  "assignment_type_id"
    t.integer  "grade_scheme_id"
    t.string   "grade_scope"
    t.string   "visible"
    t.datetime "close_time"
    t.datetime "open_time"
    t.boolean  "required"
    t.boolean  "has_assignment_submissions"
    t.boolean  "student_logged"
    t.string   "student_logged_button_text"
    t.integer  "badge_set_id"
    t.boolean  "release_necessary"
    t.datetime "open_date"
  end

  create_table "badge_sets", :force => true do |t|
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "badge_sets_courses", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "badge_set_id"
  end

  create_table "badges", :force => true do |t|
    t.integer  "assignment_id"
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.binary   "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "occurrence"
    t.integer  "badge_set_id"
    t.integer  "value"
    t.integer  "multiplier"
  end

  add_index "badges", ["assignment_id"], :name => "index_badges_on_assignment_id"

  create_table "course_badge_sets", :force => true do |t|
    t.integer "course_id"
    t.integer "badge_set_id"
  end

  create_table "course_grade_scheme_elements", :force => true do |t|
    t.string   "name"
    t.string   "letter_grade"
    t.integer  "low_range"
    t.integer  "high_range"
    t.integer  "course_grade_scheme_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "course_grade_schemes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.string   "theme_id"
    t.integer  "course_grade_scheme_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.boolean  "badge_setting",                 :default => true
    t.boolean  "team_setting",                  :default => false
    t.string   "user_term"
    t.string   "team_term"
    t.string   "homepage_message"
    t.boolean  "status",                        :default => true
    t.boolean  "group_setting"
    t.integer  "badge_set_id"
    t.integer  "user_weight_amount"
    t.integer  "min_size"
    t.integer  "max_size"
    t.datetime "user_weight_amount_close_date"
    t.boolean  "team_roles"
    t.string   "section_leader_term"
    t.string   "group_term"
    t.string   "user_weight_amount_type"
    t.boolean  "has_assignment_submissions"
    t.boolean  "teams_visible"
    t.string   "badge_use_scope"
    t.integer  "multiplier_default"
    t.string   "multiplier_term"
    t.boolean  "predictor_setting"
    t.boolean  "badges_value"
  end

  create_table "criteria", :force => true do |t|
    t.string   "name"
    t.integer  "ruberic_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "criteria_levels", :force => true do |t|
    t.string   "name"
    t.integer  "criteria_id"
    t.text     "description"
    t.integer  "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "dashboards", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "earned_badges", :force => true do |t|
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "feedback"
    t.integer  "earnable_id"
    t.string   "earnable_type"
  end

  create_table "grade_scheme_elements", :force => true do |t|
    t.string   "name"
    t.integer  "low_range"
    t.string   "letter_grade"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "grade_scheme_id"
    t.string   "description"
    t.integer  "high_range"
  end

  create_table "grade_schemes", :force => true do |t|
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.string   "name"
  end

  create_table "grades", :force => true do |t|
    t.integer  "raw_score"
    t.integer  "assignment_id"
    t.text     "feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
    t.boolean  "semis"
    t.boolean  "finals"
    t.string   "type"
    t.string   "status"
    t.boolean  "attempted"
    t.boolean  "substantial"
    t.integer  "gradeable_id"
    t.string   "gradeable_type"
    t.integer  "final_score"
    t.integer  "assignment_submission_id"
  end

  add_index "grades", ["assignment_id"], :name => "index_grades_on_assignment_id"
  add_index "grades", ["gradeable_id", "gradeable_type"], :name => "index_grades_on_graded_id_and_graded_type"

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "accepted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
    t.integer  "course_id"
    t.string   "approved"
    t.string   "proposal"
  end

  create_table "rubrics", :force => true do |t|
    t.string   "name"
    t.integer  "assignment_id"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "score_levels", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.integer  "assignment_type_id"
    t.integer  "assignment_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "team_memberships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "user_assignment_type_weights", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.integer  "assignment_type_id"
    t.integer  "value"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                               :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "role",                            :default => "student"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sortable_score"
    t.integer  "rank"
    t.string   "display_name"
    t.boolean  "private_display",                 :default => false
    t.integer  "default_course_id"
    t.string   "final_grade"
    t.integer  "visit_count"
    t.integer  "predictor_views"
    t.integer  "page_views"
    t.string   "team_role"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["sortable_score"], :name => "index_users_sortable_score"

end
