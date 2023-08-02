class CreatePessoas < ActiveRecord::Migration[7.1]
  def change
    create_table :pessoas, id: :uuid do |t|
      t.string :apelido,    null: false, index: { unique: true }
      t.string :nome,       null: false
      t.date   :nascimento, null: false

      t.string :stack

      t.timestamps
    end
  end
end
