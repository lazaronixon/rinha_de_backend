class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  self.ignored_columns = %w[searchable]

  serialize :stack, type: Array, coder: JSON
end
