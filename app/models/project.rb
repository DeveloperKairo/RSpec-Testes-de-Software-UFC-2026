class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :name,
            presence: { message: "O nome é obrigatório" },
            length: {
              minimum: 3,
              maximum: 100,
              too_short: "O nome deve ter pelo menos %{count} caracteres",
              too_long: "O nome deve ter no máximo %{count} caracteres"
            }

  validates :description,
            presence: { message: "A descrição é obrigatória" },
            length: {
              maximum: 500,
              too_long: "A descrição deve ter no máximo %{count} caracteres"
            }
end
