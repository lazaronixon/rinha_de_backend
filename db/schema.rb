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

ActiveRecord::Schema[7.1].define(version: 2023_08_01_033323) do
  create_table "pessoas", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "apelido", limit: 32, null: false
    t.string "nome", limit: 100, null: false
    t.date "nascimento", null: false
    t.string "stack"
    t.index ["apelido", "nome", "stack"], name: "index_pessoas_on_apelido_and_nome_and_stack", type: :fulltext
    t.index ["apelido"], name: "index_pessoas_on_apelido", unique: true
  end

end
