# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_11_222718) do

  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
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
    t.integer "role"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "debts", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "person_id"
    t.integer "amount_cents", default: 0, null: false
    t.integer "status", default: 0
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_debts_on_person_id"
  end

  create_table "installments", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.bigint "membership_id"
    t.integer "amount_cents", default: 0, null: false
    t.integer "status", default: 0
    t.decimal "hours", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_with_discount_cents", default: 0, comment: "Amount to pay with discount"
    t.boolean "use_amount_with_discount", default: false, comment: "Indicates if this installment was paid with a discount"
    t.boolean "apply_extra_debit_charge", default: false, comment: "Indicates if this installment was paid with debit"
    t.index ["membership_id"], name: "index_installments_on_membership_id"
  end

  create_table "installments_klasses", id: false, charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "installment_id", null: false
    t.bigint "klass_id", null: false
    t.index ["installment_id", "klass_id"], name: "index_installments_klasses_on_installment_id_and_klass_id"
    t.index ["klass_id", "installment_id"], name: "index_installments_klasses_on_klass_id_and_installment_id"
  end

  create_table "klasses", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.integer "fixed_fee_cents", default: 0, null: false
    t.bigint "teacher_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "non_regular_fee_cents"
    t.integer "fixed_fee_with_discount_cents", default: 0
    t.integer "non_regular_fee_with_discount_cents", default: 0
    t.integer "non_regular_alt_fee_cents", default: 0
    t.integer "non_regular_alt_fee_with_discount_cents", default: 0
    t.integer "fixed_alt_fee_cents", default: 0
    t.integer "fixed_alt_fee_with_discount_cents", default: 0
    t.string "discount", comment: "% value to use as a discount on the fee"
    t.index ["teacher_id"], name: "index_klasses_on_teacher_id"
  end

  create_table "klasses_packages", id: false, charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "package_id"
    t.index ["klass_id"], name: "index_klasses_packages_on_klass_id"
    t.index ["package_id"], name: "index_klasses_packages_on_package_id"
  end

  create_table "klasses_teachers", id: false, charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "teacher_id"
    t.index ["klass_id"], name: "index_klasses_teachers_on_klass_id"
    t.index ["teacher_id"], name: "index_klasses_teachers_on_teacher_id"
  end

  create_table "memberships", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "person_id"
    t.text "info"
    t.bigint "package_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.boolean "use_custom_amount", default: false
    t.boolean "use_non_regular_fee"
    t.boolean "use_fees_with_discount", default: false, comment: "Use alternative fee with discount"
    t.integer "amount_with_discount_cents", default: 0, comment: "Price of the membership using discount values"
    t.boolean "use_manual_discount", default: false, comment: "Indicates if the membership was added with a custom discount value"
    t.integer "manual_discount", comment: "The % for the manually added discount"
    t.boolean "apply_discounts"
    t.index ["package_id"], name: "index_memberships_on_package_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "memberships_schedules", id: false, charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "membership_id"
    t.bigint "schedule_id"
    t.index ["membership_id"], name: "index_memberships_schedules_on_membership_id"
    t.index ["schedule_id"], name: "index_memberships_schedules_on_schedule_id"
  end

  create_table "money_transactions", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.bigint "installment_id"
    t.bigint "person_id"
    t.string "description"
    t.boolean "done"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "daily_cash_closer", default: false
    t.string "payable_type"
    t.bigint "payable_id"
    t.integer "receipt"
    t.index ["installment_id"], name: "index_money_transactions_on_installment_id"
    t.index ["payable_type", "payable_id"], name: "index_money_transactions_on_payable_type_and_payable_id"
    t.index ["person_id"], name: "index_money_transactions_on_person_id"
  end

  create_table "packages", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fee_cents", default: 0, null: false
    t.integer "alt_fee_cents", default: 0, null: false
    t.index ["person_id"], name: "index_packages_on_person_id"
  end

  create_table "packages_schedules", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.bigint "package_id"
    t.bigint "schedule_id"
    t.index ["package_id"], name: "index_packages_schedules_on_package_id"
    t.index ["schedule_id"], name: "index_packages_schedules_on_schedule_id"
  end

  create_table "people", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
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
    t.string "source", comment: "Source: Instagram/Ads/Another student/etc"
    t.index ["source"], name: "index_people_on_source"
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
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

  create_table "settings", charset: "utf8mb4", collation: "utf8mb4_spanish_ci", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
