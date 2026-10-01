class Task < ApplicationRecord
  belongs_to :project

  validates :title,
            presence: { message: "O Titulo é obrigatório" },
            length: {
              minimum: 3,
              maximum: 100,
              too_short: "O Titulo deve ter pelo menos %{count} caracteres",
              too_long: "O Titulo deve ter no máximo %{count} caracteres"
            }

  validates :description,
            presence: { message: "A descrição é obrigatória" },
            length: {
              minimum: 10,
              maximum: 500,
              too_short: "A descrição deve ter pelo menos %{count} caracteres",
              too_long: "A descrição deve ter no máximo %{count} caracteres"
            }

  validates :status,
            presence: { message: "O Status é obrigatório" },
            inclusion: { in: [ "pending", "in_progress", "completed" ], message: "O Status deve ser pendente, em andamento ou concluído" }
end
