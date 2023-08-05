class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  serialize :stack, type: Array, coder: JSON

  def self.find_cached(id)
    Rails.cache.fetch("v1/pessoas/#{id}") { find(id) }
  end

  private
    def attribute_names_for_serialization
      %i[id apelido nome nascimento stack]
    end
end
