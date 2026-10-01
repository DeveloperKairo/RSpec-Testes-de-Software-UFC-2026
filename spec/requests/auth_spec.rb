require 'rails_helper'

RSpec.describe "Auth API", type: :request do
  describe "POST /register" do
    let(:valid_params) do
      {
        user: {
          name: "João Silva",
          email: "joao@email.com",
          age: 25,
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    it "cadastra um novo usuário com sucesso" do
      post "/register", params: valid_params, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response["user"]["email"]).to eq("joao@email.com")
      expect(json_response["user"]).not_to have_key("password_digest")
    end

    it "retorna erro quando os dados são inválidos" do
      invalid_params = valid_params.dup
      invalid_params[:user][:email] = ""

      post "/register", params: invalid_params, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response["errors"]).to have_key("email")
    end
  end

  describe "POST /login" do
    let!(:user) { User.create!(name: "Maria", email: "maria@email.com", age: 30, password: "password123") }

    it "faz login com sucesso e retorna o token" do
      post "/login", params: { email: user.email, password: "password123" }, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("token")
      expect(json_response["user"]["email"]).to eq(user.email)
    end

    it "falha ao tentar fazer login com senha incorreta" do
      post "/login", params: { email: user.email, password: "wrongpassword" }, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:unauthorized)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Email ou senha inválidos")
    end
  end

  describe "GET /me" do
    let!(:user) { User.create!(name: "Carlos", email: "carlos@email.com", age: 40, password: "password123") }

    it "retorna os dados do usuário quando está autenticado" do
      get "/me", headers: { "Authorization" => "Bearer #{user.auth_token}", "Accept" => "application/json" }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["user"]["name"]).to eq("Carlos")
    end

    it "retorna erro de autenticação quando o token não é enviado" do
      get "/me", headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:unauthorized)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Autenticação necessária")
    end
  end
end
