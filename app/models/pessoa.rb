class Pessoa < ApplicationRecord
  self.ignored_columns = %w[searchable]

  serialize :stack, type: Array, coder: TagCoder

  scope :search, -> (value) { where("pessoas.searchable ILIKE ?", "%#{value}%") }

  validates :apelido,    presence: true, length: { maximum: 32  }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, presence: true

  validate :apelido_must_be_unique

  validate :stack_must_contain_valid_elements

  def self.find_cached(id)
    Rails.cache.fetch("pessoas/#{id}") { find(id) }
  end

  def self.create_in_batch_later!(pessoa_params)
    pessoa = Pessoa.new(pessoa_params.merge(id: SecureRandom.uuid))
    pessoa.validate!

    pessoa.create_cache_for_record
    pessoa.create_cache_for_apelido
    pessoa.create_in_batch_later
    pessoa
  end

  def create_cache_for_record
    Rails.cache.write("pessoas/#{id}", self)
  end

  def create_cache_for_apelido
    Rails.cache.write("pessoas/apelido/#{apelido}", true)
  end

  def create_in_batch_later
    PessoasCreatorJob.perform_async("pessoas/#{id}")
  end

  private
    def apelido_must_be_unique
      errors.add(:apelido, :taken) if has_apelido_on_cache?
    end

    def has_apelido_on_cache?
      Rails.cache.exist?("pessoas/apelido/#{apelido}")
    end

    def stack_must_contain_valid_elements
      errors.add(:stack, :invalid) unless stack.all? { |item| valid_stack_element?(item) }
    end

    def valid_stack_element?(item)
      item.is_a?(String) && item.present? && item.size <= 32
    end
end
