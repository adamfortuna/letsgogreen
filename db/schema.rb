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

ActiveRecord::Schema.define(:version => 20120704051048) do

  create_table "bills", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id",         :null => false
    t.string   "payee",           :null => false
    t.decimal  "amount",          :null => false
    t.date     "date"
    t.text     "description"
    t.string   "schedule"
    t.string   "title"
    t.boolean  "variable_amount"
  end

  create_table "budgets", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id",     :null => false
    t.string   "title",       :null => false
    t.decimal  "amount",      :null => false
    t.text     "description"
    t.string   "schedule",    :null => false
  end

  create_table "categories", :force => true do |t|
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "type"
    t.integer  "user_id",                            :null => false
    t.string   "title",                              :null => false
    t.string   "alias"
    t.decimal  "amount",                             :null => false
    t.text     "description"
    t.boolean  "variable_amount", :default => false, :null => false
    t.string   "schedule"
    t.boolean  "after_tax",       :default => true,  :null => false
  end

  create_table "expenses", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id",          :null => false
    t.string   "payee",            :null => false
    t.decimal  "amount",           :null => false
    t.date     "date",             :null => false
    t.text     "description"
    t.integer  "accountable_id"
    t.string   "accountable_type"
  end

  create_table "incomes", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id",     :null => false
    t.string   "name",        :null => false
    t.decimal  "amount",      :null => false
    t.date     "date",        :null => false
    t.text     "description"
    t.string   "schedule"
  end

  create_table "savings", :force => true do |t|
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "user_id",                                   :null => false
    t.string   "title",                                     :null => false
    t.decimal  "amount",                                    :null => false
    t.text     "description"
    t.string   "schedule"
    t.boolean  "variable_amount"
    t.boolean  "from_before_tax_income", :default => false
  end

  create_table "transactions", :force => true do |t|
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "type"
    t.integer  "category_id"
    t.integer  "user_id",                       :null => false
    t.string   "title",                         :null => false
    t.decimal  "amount",                        :null => false
    t.date     "date",                          :null => false
    t.text     "description"
    t.boolean  "after_tax",   :default => true, :null => false
    t.boolean  "confirmed",   :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
