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

ActiveRecord::Schema.define(:version => 20120204023633) do

  create_table "assignments", :force => true do |t|
    t.string    "title"
    t.string    "description"
    t.integer   "point_total"
    t.timestamp "due_date"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "level"
    t.string    "type"
    t.boolean   "substantial", :default => false
    t.boolean   "present"
  end

  create_table "badges", :force => true do |t|
    t.integer   "assignment_id"
    t.string    "title"
    t.string    "description"
    t.string    "icon"
    t.binary    "visible"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
  end

  add_index "badges", ["assignment_id"], :name => "index_badges_on_assignment_id"

  create_table "challenge_scores", :force => true do |t|
    t.integer   "score"
    t.string    "feedback"
    t.integer   "team_id"
    t.integer   "challenge_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "type"
  end

  create_table "challenges", :force => true do |t|
    t.string    "title"
    t.integer   "points"
    t.string    "description"
    t.timestamp "date"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "type"
  end

  create_table "dashboards", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "earned_badges", :force => true do |t|
    t.integer   "grade_id"
    t.integer   "badge_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "grade_schemes", :force => true do |t|
    t.integer   "assignment_id"
    t.integer   "ascore"
    t.integer   "amscore"
    t.integer   "bpscore"
    t.integer   "bscore"
    t.integer   "bmscore"
    t.integer   "cpscore"
    t.integer   "cscore"
    t.integer   "cmscore"
    t.integer   "dpscore"
    t.integer   "dscore"
    t.integer   "dmscore"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "apscore"
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
  end

  add_index "grades", ["assignment_id"], :name => "index_grades_on_assignment_id"
  add_index "grades", ["badge_id"], :name => "index_grades_on_badge_id"
  add_index "grades", ["user_id"], :name => "index_grades_on_user_id"

  create_table "groups", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "banner_file_name"
    t.string    "banner_content_type"
    t.integer   "banner_file_size"
    t.timestamp "banner_updated_at"
    t.integer   "score"
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
    t.integer   "score"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
