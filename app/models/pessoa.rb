class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  serialize :stack, type: Array, coder: JSON

  validates :apelido,    presence: true, uniqueness: true, length: { maximum: 32 }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }

  def attribute_names_for_serialization
    %i[id apelido nome nascimento stack]
  end
end
