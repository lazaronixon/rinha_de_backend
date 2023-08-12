class Pessoa < ApplicationRecord
  self.ignored_columns = %w[searchable]

  serialize :stack, coder: JSON

  scope :search, -> (value) { where("MATCH(apelido, nome, stack) AGAINST(? IN BOOLEAN MODE)", value) }

  validates :apelido,    presence: true, length: { maximum: 32  }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, presence: true
  validates :stack,      presence: true, allow_nil: true

  validate :stack_must_contain_valid_elements

  private
    def stack_must_contain_valid_elements
      errors.add(:stack, :invalid) unless stack&.all? { |item| stack_element?(item) }
    end

    def stack_element?(item)
      item.is_a?(String) && item.present? && item.size <= 32
    end
end
