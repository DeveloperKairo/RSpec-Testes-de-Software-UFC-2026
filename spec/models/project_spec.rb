require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) do
    User.create(
      name: "Italo",
      email: "italo#{SecureRandom.hex(4)}@email.com",
      age: 25,
        password: "password123"
    )
  end

  describe "validacoes do nome" do
    it "é inválido quando o nome está ausente" do
      project = Project.new(
        name: nil,
        description: "Descrição do projeto",
        user: user
      )
      project.valid?

      expect(project.errors[:name]).to include("O nome é obrigatório")
    end

    it "é inválido quando o nome tem menos de 3 caracteres" do
      project = Project.new(
        name: "AB",
        description: "Descrição do projeto",
        user: user
      )
      project.valid?

      expect(project.errors[:name]).to include("O nome deve ter pelo menos 3 caracteres")
    end

    it "é inválido quando o nome tem mais de 100 caracteres" do
      project = Project.new(
        name: "A" * 101,
        description: "Descrição do projeto",
        user: user
      )
      project.valid?

      expect(project.errors[:name]).to include("O nome deve ter no máximo 100 caracteres")
    end
  end

  describe "validacoes da descrição" do
    it "é inválido quando a descrição está ausente" do
      project = Project.new(
        name: "Projeto 1",
        description: nil,
        user: user
      )
      project.valid?

      expect(project.errors[:description]).to include("A descrição é obrigatória")
    end

    it "é inválido quando a descrição tem mais de 500 caracteres" do
      project = Project.new(
        name: "Projeto 1",
        description: "A" * 501,
        user: user
      )
      project.valid?

      expect(project.errors[:description]).to include("A descrição deve ter no máximo 500 caracteres")
    end
  end

  describe "validacoes do usuario" do
    it "é inválido quando o usuário está ausente" do
      project = Project.new(
        name: "Projeto 1",
        description: "Descrição do projeto",
        user: nil
      )

      expect(project).to be_invalid
    end
  end

  describe "casos válidos" do
    it "é válido com todos os atributos preenchidos corretamente" do
      project = Project.new(
        name: "Projeto Válido",
        description: "Esta é uma descrição válida com mais de alguns caracteres.",
        user: user
      )
      
      expect(project).to be_valid
    end
  end

  describe "associações" do
    it "apaga as tarefas associadas quando o projeto é deletado" do
      project = Project.create!(
        name: "Projeto Válido",
        description: "Esta é uma descrição válida",
        user: user
      )
      
      Task.create!(
        title: "Tarefa 1",
        description: "Descrição da tarefa muito longa",
        status: "pending",
        project: project
      )

      expect { project.destroy }.to change { Task.count }.by(-1)
    end
  end
end
