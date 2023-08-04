class Pessoa < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, using: { tsearch: { prefix: true, tsvector_column: :searchable } }

  serialize :stack, type: Array, coder: JSON

  validate :stack_must_have_only_string_elements
  validate :stack_must_have_only_32_chars_elements

  private
    def stack_must_have_only_string_elements
      unless stack&.all? { |item| item.is_a?(String) }
        errors.add(:stack, "must have only string elements")
      end
    end

    def stack_must_have_only_32_chars_elements
      unless stack&.all? { |item| item.to_s.size <= 32 }
        errors.add(:stack, "must have only 32 chars elements")
      end
    end

    def attribute_names_for_serialization
      %i[id apelido nome nascimento stack]
    end
end
