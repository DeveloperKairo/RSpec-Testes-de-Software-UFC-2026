class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :projects, dependent: :destroy

  validates :name,
            presence: { message: "Nome é obrigatório" },
            length: {
              minimum: 3,
              maximum: 100,
              too_short: "Nome deve ter pelo menos %{count} caracteres",
              too_long: "Nome deve ter no máximo %{count} caracteres"
            }

  validates :email,
            presence: { message: "Email é obrigatório" },
            length: {
              minimum: 6,
              maximum: 255,
              too_short: "Email deve ter pelo menos %{count} caracteres",
              too_long: "Email deve ter no máximo %{count} caracteres"
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "Um e-mail válido deve ser inserido"
            },
            uniqueness: {
              message: "Este e-mail já está cadastrado."
            }
  validates :age, presence: { message: "Idade é obrigatória" }
  validates :age, numericality: { only_integer: true, message: "deve ser um número inteiro" }
  validates :age, numericality: { greater_than_or_equal_to: 18, message: "deve ser maior ou igual a 18" }
  validates :age, numericality: { less_than_or_equal_to: 120, message: "deve ser menor ou igual a 120" }
end
