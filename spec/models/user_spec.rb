require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validacoes gerais" do
    it "é válido quando as informacoes sao preenchidas de forma correta" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 20,
        password: "password123"
      )
      expect(user).to be_valid
    end
  end
  describe "validacoes do nome" do
    it "é inválido quando o nome tem menos de 3 caracteres" do
      user = User.new(
        name: "Jo",
        email: "jo@email.com",
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:name]).to include("Nome deve ter pelo menos 3 caracteres")
    end

    it "é inválido quando o nome tem mais de 100 caracteres" do
      user = User.new(
        name: "A" * 101,
        email: "italo@email.com",
        age: 25,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:name]).to include("Nome deve ter no máximo 100 caracteres")
    end

    it "é inválido quando o nome está ausente" do
      user = User.new(
        name: nil,
        email: "nulo@email.com",
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:name]).to include("Nome é obrigatório")
    end
  end

  describe "validacoes do email" do
    it "é inválido quando o email está ausente" do
      user = User.new(
        name: "Italo",
        email: nil,
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:email]).to include("Email é obrigatório")
    end

    it "é inválido quando o email tem menos de 6 caracteres" do
      user = User.new(
        name: "Italo",
        email: "i@a.c",
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:email]).to include("Email deve ter pelo menos 6 caracteres")
    end

    it "é inválido quando o email tem mais de 255 caracteres" do
      user = User.new(
        name: "Italo",
        email: "a" * 255 + "@email.com",
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:email]).to include("Email deve ter no máximo 255 caracteres")
    end

    it "é inválido quando o email tem formato incorreto" do
      user = User.new(
        name: "Italo",
        email: "Italo",
        age: 20,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:email]).to include("Um e-mail válido deve ser inserido")
    end

    it "é inválido quando o email não é único" do
      user1 = User.create(
        name: "Italo",
        email: "correto@email.com",
        age: 20,
        password: "password123"
      )

      user2 = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 25,
        password: "password123"
      )
      user2.valid?

      expect(user2.errors[:email]).to include("Este e-mail já está cadastrado.")
    end
  end

  describe "validacoes da idade" do
    it "é inválido quando a idade está ausente" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: nil
      )
      user.valid?

      expect(user.errors[:age]).to include("Idade é obrigatória")
    end

    it "é inválido quando a idade é menor que 18" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 17,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:age]).to include("deve ser maior ou igual a 18")
    end

    it "é inválido quando a idade é maior que 120" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 121,
        password: "password123"
      )
      user.valid?

      expect(user.errors[:age]).to include("deve ser menor ou igual a 120")
    end

    it "é inválido quando a idade não é um número inteiro" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: "texto",
        password: "password123"
      )
      user.valid?

      expect(user.errors[:age]).to include("deve ser um número inteiro")
    end
  end

  describe "validações da senha" do
    it "é inválido quando a senha tem menos de 6 caracteres" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 20,
        password: "12345"
      )
      user.valid?

      expect(user.errors[:password]).to be_present
    end

    it "é inválido quando a senha está ausente" do
      user = User.new(
        name: "Italo",
        email: "correto@email.com",
        age: 20,
        password: nil
      )
      user.valid?

      expect(user.errors[:password]).to be_present
    end
  end

  describe "associações" do
    it "apaga os projetos associados quando o usuário é deletado" do
      user = User.create!(
        name: "Italo",
        email: "correto#{SecureRandom.hex(4)}@email.com",
        age: 20,
        password: "password123"
      )
      
      Project.create!(
        name: "Projeto do Italo",
        description: "Descrição",
        user: user
      )

      expect { user.destroy }.to change { Project.count }.by(-1)
    end
  end
end
