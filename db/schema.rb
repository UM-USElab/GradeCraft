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

ActiveRecord::Schema.define(:version => 20120713225929) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "point_total"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
    t.string   "type"
    t.boolean  "present"
    t.integer  "course_id"
  end

  create_table "badge_sets", :force => true do |t|
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "badges", :force => true do |t|
    t.integer  "assignment_id"
    t.string   "title"
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
  end

  add_index "badges", ["assignment_id"], :name => "index_badges_on_assignment_id"

  create_table "challenge_grades", :force => true do |t|
    t.integer  "score"
    t.string   "feedback"
    t.integer  "team_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
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
    t.datetime "year"
    t.string   "semester"
    t.integer  "badge_sets_id"
    t.string   "theme_id"
    t.integer  "coursegradescheme"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "badge_setting",     :default => true
    t.boolean  "team_setting",      :default => false
    t.string   "user_term"
    t.string   "team_term"
    t.string   "homepage_message"
    t.boolean  "status",            :default => true
  end

  create_table "dashboards", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "earned_badges", :force => true do |t|
    t.integer  "grade_id"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_schemes", :force => true do |t|
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_name"
    t.integer  "range_bottom"
    t.integer  "range_top"
  end

  create_table "grades", :force => true do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.text     "feedback"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
    t.boolean  "semis"
    t.boolean  "finals"
    t.string   "type"
    t.string   "status"
    t.boolean  "attempted"
    t.boolean  "substantial"
  end

  add_index "grades", ["assignment_id"], :name => "index_grades_on_assignment_id"
  add_index "grades", ["badge_id"], :name => "index_grades_on_badge_id"
  add_index "grades", ["user_id"], :name => "index_grades_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "team_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sortable_score"
    t.integer  "rank"
    t.string   "display_name"
    t.boolean  "private_display",                 :default => false
    t.integer  "default_course_id"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
