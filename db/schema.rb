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

ActiveRecord::Schema.define(version: 20180519002126) do

  create_table "admins", force: :cascade do |t|
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

  create_table "installments", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.integer "membership_id"
    t.integer "amount_cents", default: 0, null: false
    t.integer "status", default: 0
    t.decimal "hours", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_installments_on_membership_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name"
    t.integer "fixed_fee_cents", default: 0, null: false
    t.integer "teacher_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_klasses_on_teacher_id"
  end

  create_table "klasses_packages", force: :cascade do |t|
    t.integer "klass_id"
    t.integer "package_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "person_id"
    t.text "info"
    t.string "for_type"
    t.integer "for_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.index ["for_type", "for_id"], name: "index_memberships_on_for_type_and_for_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "memberships_schedules", id: false, force: :cascade do |t|
    t.integer "membership_id"
    t.integer "schedule_id"
    t.index ["membership_id"], name: "index_memberships_schedules_on_membership_id"
    t.index ["schedule_id"], name: "index_memberships_schedules_on_schedule_id"
  end

  create_table "money_transactions", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.integer "installment_id"
    t.integer "person_id"
    t.string "description"
    t.boolean "done"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "daily_cash_closer", default: false
    t.index ["installment_id"], name: "index_money_transactions_on_installment_id"
    t.index ["person_id"], name: "index_money_transactions_on_person_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_packages_on_person_id"
  end

  create_table "people", force: :cascade do |t|
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
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "klass_id"
    t.string "from_time", limit: 5
    t.string "to_time", limit: 5
    t.integer "day", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "room", default: ""
    t.index ["klass_id"], name: "index_schedules_on_klass_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
