class Pessoa < ApplicationRecord
  validates :apelido,    presence: true, uniqueness: true, length: { maximum: 32 }
  validates :nome,       presence: true, length: { maximum: 100 }
  validates :nascimento, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
end
