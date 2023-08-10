class AddIndexPessoasOnSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :pessoas, :searchable, :virtual, type: :tsvector, as: "to_tsvector('simple', apelido || ' ' || nome || ' ' || coalesce(stack, ''))", stored: true
    add_index  :pessoas, :searchable, using: :gin
  end
end
