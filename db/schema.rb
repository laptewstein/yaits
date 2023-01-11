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

ActiveRecord::Schema.define(version: 2022_02_26_040845) do

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "disciplines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", limit: 32, null: false
    t.index ["label"], name: "label", unique: true
  end

  create_table "employee_projects", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_employee_projects_on_employee_id"
    t.index ["project_id"], name: "index_employee_projects_on_project_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "salary"
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "issue_priorities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", limit: 32, null: false
    t.integer "value", null: false
    t.index ["label", "value"], name: "index_on_label_and_value", unique: true
    t.index ["label"], name: "label", unique: true
  end

  create_table "issue_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", limit: 32, null: false
    t.index ["label"], name: "label", unique: true
  end

  create_table "issues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", limit: 191, null: false
    t.text "description"
    t.integer "issue_priority_id"
    t.integer "issue_status_id"
    t.integer "discipline_id"
    t.index ["title"], name: "title", unique: true
  end

  create_table "issues_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "issue_id"
    t.bigint "user_id"
    t.index ["issue_id", "user_id"], name: "index_on_issue_id_and_user_id", unique: true
    t.index ["issue_id"], name: "index_issues_users_on_issue_id"
    t.index ["user_id"], name: "index_issues_users_on_user_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.integer "budget"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.boolean "enabled", default: true
    t.string "salt", limit: 40
    t.index ["email"], name: "email", unique: true
  end

end
