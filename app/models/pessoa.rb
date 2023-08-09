class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  serialize :stack, type: Array, coder: JSON

  private
    def attribute_names_for_serialization
      %i[id apelido nome nascimento stack]
    end
end
