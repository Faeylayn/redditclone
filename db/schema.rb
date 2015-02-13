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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150213195847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "content",           null: false
    t.integer  "commenter_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "parent_comment_id"
  end

  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "post_subbings", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_subbings", ["post_id"], name: "index_post_subbings_on_post_id", using: :btree
  add_index "post_subbings", ["sub_id"], name: "index_post_subbings_on_sub_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content",    null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree

  create_table "subs", force: true do |t|
    t.string   "title",        null: false
    t.string   "description",  null: false
    t.integer  "moderator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sessions_token"
  end

  create_table "votes", force: true do |t|
    t.integer  "value",        null: false
    t.integer  "votable_id",   null: false
    t.string   "votable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "voter_id"
  end

  add_index "votes", ["voter_id", "votable_id", "votable_type"], name: "index_votes_on_voter_id_and_votable_id_and_votable_type", unique: true, using: :btree

end
