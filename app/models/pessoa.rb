class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  self.ignored_columns = %w[searchable]

  serialize :stack, type: Array, coder: JSON

  validates :apelido,    presence: true, length: { maximum: 32  }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }  
end
