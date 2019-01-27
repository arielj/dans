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

ActiveRecord::Schema.define(version: 2019_01_27_163546) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
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
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "installments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.bigint "membership_id"
    t.integer "amount_cents", default: 0, null: false
    t.integer "status", default: 0
    t.decimal "hours", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_installments_on_membership_id"
  end

  create_table "klasses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.integer "fixed_fee_cents", default: 0, null: false
    t.bigint "teacher_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_klasses_on_teacher_id"
  end

  create_table "klasses_packages", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "package_id"
    t.index ["klass_id"], name: "index_klasses_packages_on_klass_id"
    t.index ["package_id"], name: "index_klasses_packages_on_package_id"
  end

  create_table "memberships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "person_id"
    t.text "info"
    t.bigint "package_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.index ["package_id"], name: "index_memberships_on_package_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "memberships_schedules", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "membership_id"
    t.bigint "schedule_id"
    t.index ["membership_id"], name: "index_memberships_schedules_on_membership_id"
    t.index ["schedule_id"], name: "index_memberships_schedules_on_schedule_id"
  end

  create_table "money_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.bigint "installment_id"
    t.bigint "person_id"
    t.string "description"
    t.boolean "done"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "daily_cash_closer", default: false
    t.index ["installment_id"], name: "index_money_transactions_on_installment_id"
    t.index ["person_id"], name: "index_money_transactions_on_person_id"
  end

  create_table "packages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_packages_on_person_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "dni", limit: 10
    t.string "cellphone"
    t.string "alt_phone"
    t.date "birthday"
    t.string "address"
    t.boolean "female", default: true
    t.text "email"
    t.boolean "is_teacher", default: false
    t.text "comments"
    t.string "facebook_id"
    t.integer "age"
    t.integer "status", default: 1
    t.integer "family_group_id"
    t.string "group", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gender"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.integer "from_time"
    t.integer "to_time"
    t.index ["klass_id"], name: "index_schedules_on_klass_id"
    t.index ["room_id"], name: "index_schedules_on_room_id"
  end

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
