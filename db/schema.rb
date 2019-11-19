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

ActiveRecord::Schema.define(version: 2019_11_19_010920) do

  create_table "reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "report_date", null: false
    t.string "com_name", null: false
    t.string "exam_method"
    t.date "exam_date", null: false
    t.string "exam_place", null: false
    t.string "exam_grade", null: false
    t.string "exam_content"
    t.string "exam_detail"
    t.string "free_comment"
    t.string "result"
    t.date "due_date"
    t.string "teached_comment"
    t.string "student_id"
    t.string "teacher_id"
    t.boolean "auth_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notice_method"
  end

  create_table "users", primary_key: "user_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "name", null: false
    t.string "class_number", limit: 6
    t.string "mail"
    t.string "teacher_id"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
