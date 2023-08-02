class CreatePessoas < ActiveRecord::Migration[7.1]
  def change
    create_table :pessoas, id: :uuid do |t|
      t.string :apelido,    null: false, index: { unique: true }, limit: 32
      t.string :nome,       null: false, limit: 100
      t.date   :nascimento, null: false

      t.string :stack

      t.timestamps
    end
  end
end
