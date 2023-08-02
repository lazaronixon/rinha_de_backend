class AddIndexPessoasOnSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :pessoas, :searchable, :virtual, type: :tsvector, as: %Q(to_tsvector('simple', apelido) || to_tsvector('simple', nome) || to_tsvector('simple', coalesce(stack, ''))), stored: true
    add_index  :pessoas, :searchable, using: :gin
  end
end
