class CreatePessoas < ActiveRecord::Migration[7.1]
  def change
    create_table :pessoas, id: false do |t|
      t.string :id,         null: false, primary_key: true, limit: 36
      t.string :apelido,    null: false, index: { unique: true }, limit: 32
      t.string :nome,       null: false, limit: 100
      t.date   :nascimento, null: false
      t.string :stack
    end

    add_index :pessoas, %i[apelido nome stack], type: :fulltext
  end
end
