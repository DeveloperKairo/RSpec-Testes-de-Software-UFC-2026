require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(
      name: "Italo",
      email: "italo#{SecureRandom.hex(4)}@email.com",
      age: 25,
        password: "password123"
    )
  end

  let(:project) do
    Project.create(
      name: "Projeto 1",
      description: "Descrição válida do projeto",
      user: user
    )
  end

  describe "validações do título" do
    it "é inválido quando o título está ausente" do
      task = Task.new(
        title: nil,
        description: "Descrição válida para a tarefa",
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:title]).to include("O Titulo é obrigatório")
    end

    it "é inválido quando o título tem menos de 3 caracteres" do
      task = Task.new(
        title: "AB",
        description: "Descrição válida para a tarefa",
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:title]).to include("O Titulo deve ter pelo menos 3 caracteres")
    end

    it "é inválido quando o título tem mais de 100 caracteres" do
      task = Task.new(
        title: "A" * 101,
        description: "Descrição válida para a tarefa",
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:title]).to include("O Titulo deve ter no máximo 100 caracteres")
    end
  end

  describe "validações da descrição" do
    it "é inválido quando a descrição está ausente" do
      task = Task.new(
        title: "Título da Tarefa",
        description: nil,
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:description]).to include("A descrição é obrigatória")
    end

    it "é inválido quando a descrição tem menos de 10 caracteres" do
      task = Task.new(
        title: "Título da Tarefa",
        description: "Curta",
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:description]).to include("A descrição deve ter pelo menos 10 caracteres")
    end

    it "é inválido quando a descrição tem mais de 500 caracteres" do
      task = Task.new(
        title: "Título da Tarefa",
        description: "A" * 501,
        status: "pending",
        project: project
      )
      task.valid?

      expect(task.errors[:description]).to include("A descrição deve ter no máximo 500 caracteres")
    end
  end

  describe "validações de status" do
    it "é inválido quando o status está ausente" do
      task = Task.new(
        title: "Título da Tarefa",
        description: "Descrição válida para a tarefa",
        status: nil,
        project: project
      )
      task.valid?

      expect(task.errors[:status]).to include("O Status é obrigatório")
    end

    it "é inválido quando o status não faz parte da lista permitida" do
      task = Task.new(
        title: "Título da Tarefa",
        description: "Descrição válida para a tarefa",
        status: "canceled",
        project: project
      )
      task.valid?

      expect(task.errors[:status]).to include("O Status deve ser pendente, em andamento ou concluído")
    end
  end

  describe "validações do projeto" do
    it "é inválido quando o projeto está ausente" do
      task = Task.new(
        title: "Título da Tarefa",
        description: "Descrição válida para a tarefa",
        status: "pending",
        project: nil
      )
      
      expect(task).to be_invalid
    end
  end

  describe "casos válidos" do
    it "é válido com todos os atributos corretos e status 'pending'" do
      task = Task.new(
        title: "Título Válido",
        description: "Esta é uma descrição longa o suficiente.",
        status: "pending",
        project: project
      )
      
      expect(task).to be_valid
    end

    it "é válido com todos os atributos corretos e status 'in_progress'" do
      task = Task.new(
        title: "Título Válido",
        description: "Esta é uma descrição longa o suficiente.",
        status: "in_progress",
        project: project
      )
      
      expect(task).to be_valid
    end

    it "é válido com todos os atributos corretos e status 'completed'" do
      task = Task.new(
        title: "Título Válido",
        description: "Esta é uma descrição longa o suficiente.",
        status: "completed",
        project: project
      )
      
      expect(task).to be_valid
    end
  end
end
