require 'rails_helper'

RSpec.describe "Projects API", type: :request do
  let!(:user) do
    User.create!(name: "Joao da Silva", email: "joao@email.com", age: 20, password: "password123")
  end

  let!(:other_user) do
    User.create!(name: "Outro User", email: "outro@email.com", age: 25, password: "password123")
  end

  let!(:project) do
    Project.create!(name: "Projeto do Joao", description: "Desc", user: user)
  end

  let(:headers) do
    { "Authorization" => "Bearer #{user.auth_token}", "Accept" => "application/json" }
  end

  describe "GET /projects" do
    it "lista apenas os projetos do usuário logado" do
      Project.create!(name: "Projeto de outro", description: "Desc", user: other_user)

      get "/projects", headers: headers

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
      expect(json_response.first["name"]).to eq("Projeto do Joao")
    end

    it "retorna 401 sem autenticação" do
      get "/projects", headers: { "Accept" => "application/json" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /projects" do
    it "cria um projeto com sucesso para o usuário logado" do
      expect {
        post "/projects", params: {
          project: {
            name: "Meu Novo Projeto",
            description: "Projeto de demonstracao"
          }
        }, headers: headers
      }.to change(Project, :count).by(1)

      expect(response).to have_http_status(:created)
      
      # Verifica se o projeto criado pertence realmente ao user
      json_response = JSON.parse(response.body)
      expect(json_response["user_id"]).to eq(user.id)
    end
  end

  describe "GET /projects/:id" do
    it "retorna o projeto caso pertença ao usuário" do
      get "/projects/#{project.id}", headers: headers

      expect(response).to have_http_status(:ok)
    end

    it "retorna 404 caso tente acessar o projeto de outra pessoa" do
      other_project = Project.create!(name: "Projeto 2", description: "D", user: other_user)

      get "/projects/#{other_project.id}", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
