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

ActiveRecord::Schema.define(:version => 20130211113456) do

  create_table "amis", :force => true do |t|
    t.string   "image_id"
    t.string   "description"
    t.string   "architecture"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "environments", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "provisioned"
    t.string   "key_pair_name"
    t.string   "security_group"
    t.string   "provision_status"
    t.string   "aws_name"
    t.integer  "region_id"
  end

  create_table "instance_relationships", :force => true do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  create_table "instance_types", :force => true do |t|
    t.string   "name"
    t.string   "size"
    t.integer  "resource_type_id"
    t.string   "label"
    t.string   "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "api_name"
  end

  create_table "instances", :force => true do |t|
    t.string   "label"
    t.integer  "xpos"
    t.integer  "ypos"
    t.integer  "instance_type_id"
    t.integer  "environment_id"
    t.integer  "resource_type_id"
    t.string   "url"
    t.string   "aws_instance_id"
    t.text     "config_attributes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "aws_label"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "frame_work"
    t.boolean  "managed",     :default => true
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "aws_name"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"

  create_table "regions", :force => true do |t|
    t.string "name"
    t.string "display_name"
    t.float  "latitude"
    t.float  "longitude"
  end

  create_table "resource_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "parents_list"
    t.string   "resource_class"
    t.string   "small_icon"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "roles"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                    :default => "", :null => false
    t.string   "encrypted_password",       :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "name"
    t.string   "aws_access_key"
    t.string   "encrypted_aws_secret_key"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
