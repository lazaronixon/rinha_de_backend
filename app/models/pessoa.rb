class Pessoa < ApplicationRecord
  self.ignored_columns = %w[searchable]

  serialize :stack, type: Array, coder: JSON

  scope :search, -> (value) { where("pessoas.searchable @@ plainto_tsquery(?)", value) }

  validates :apelido,    presence: true, length: { maximum: 32  }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, presence: true

  validate :apelido_must_be_unique
  validate :stack_must_contain_valid_elements

  after_create_commit :create_cache_for_id
  after_create_commit :create_cache_for_apelido

  def self.find_cached(id)
    Rails.cache.fetch("pessoas/#{id}") { find(id) }
  end

  private
    def apelido_must_be_unique
      errors.add(:apelido, :taken) if has_apelido_on_cache?
    end

    def stack_must_contain_valid_elements
      errors.add(:stack, :invalid) unless stack.all? { |item| valid_stack_element?(item) }
    end

    def valid_stack_element?(item)
      item.is_a?(String) && item.present? && item.size <= 32
    end

    def create_cache_for_id
      Rails.cache.write("pessoas/#{id}", self)
    end

    def create_cache_for_apelido
      Rails.cache.write("pessoas/apelido/#{apelido}", true)
    end

    def has_apelido_on_cache?
      Rails.cache.exist?("pessoas/apelido/#{apelido}")
    end
end
