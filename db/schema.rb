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

ActiveRecord::Schema.define(version: 2021_04_10_160617) do

  create_table "estoques", force: :cascade do |t|
    t.integer "produtos_id"
    t.integer "local_armazenamentos_id"
    t.integer "quantidade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_armazenamentos_id"], name: "index_estoques_on_local_armazenamentos_id"
    t.index ["produtos_id"], name: "index_estoques_on_produtos_id"
  end

  create_table "local_armazenamentos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movimentacaos", force: :cascade do |t|
    t.integer "produtos_id"
    t.integer "local_armazenamentos_id"
    t.string "tipo"
    t.datetime "data"
    t.integer "quantidade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_armazenamentos_id"], name: "index_movimentacaos_on_local_armazenamentos_id"
    t.index ["produtos_id"], name: "index_movimentacaos_on_produtos_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "estoques", "local_armazenamentos", column: "local_armazenamentos_id"
  add_foreign_key "estoques", "produtos", column: "produtos_id"
  add_foreign_key "movimentacaos", "local_armazenamentos", column: "local_armazenamentos_id"
  add_foreign_key "movimentacaos", "produtos", column: "produtos_id"
end
