# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080423170543) do

  create_table "answers", :force => true do |t|
    t.string   "date"
    t.string   "major_subject"
    t.string   "member"
    t.string   "minor_subject"
    t.string   "questions"
    t.string   "role"
    t.string   "text"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "member"
    t.string   "text"
    t.string   "uin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
